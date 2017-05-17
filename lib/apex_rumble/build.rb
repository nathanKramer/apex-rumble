require "erb"
require "fileutils"
require "apex_rumble/metadata/apex_class"
require "apex_rumble/metadata/sobject"
require "apex_rumble/metadata/custom_field"
require "apex_rumble/metadata/schema_reader"
module ApexRumble

  DEFAULT_SCHEMA_DIR = './src/objects'
  DEFAULT_OUTPUT_DIR = './apex_bin'

  class Build

    def initialize(schema_dir, output_dir)
      @schema_dir = schema_dir
      @output_dir = output_dir
      validate
    end

    def run
      # hard code some sobjects for. In the future these should be worked out in an intelligent fashion
      apex_classes = []
      FileUtils::mkdir_p "#{@output_dir}/classes"
      static_classes = Dir.glob("#{ApexRumble.source_dir}/api/*.cls")
      static_classes.each { |file_name|
        content = IO.read(file_name)
        class_name = File.basename(file_name, '.cls')
        apex_classes.push(ApexClass.new(class_name, content))
      }
      dynamic_classes = Dir.glob("#{ApexRumble.source_dir}/api/*.cls.erb")
      dynamic_classes.each { |file_name|
        template = IO.read(file_name)
        class_name = File.basename(file_name, '.cls.erb')

        compiler = ERB.new(template)
        content = compiler.result(binding)
        apex_classes.push(ApexClass.new(class_name, content))
      }

      templates = {
        model_base: IO.read("#{ApexRumble.source_dir}/models/model_base.cls.erb"),
        model: IO.read("#{ApexRumble.source_dir}/models/model.cls.erb")
      }

      records.each { |record|
        compiler = ERB.new(templates[:model_base])
        result = compiler.result(binding)
        apex_classes.push(ApexClass.new("Rumble#{record.class_name}", result))

        compiler = ERB.new(templates[:model])
        result = compiler.result(binding)
        apex_classes.push(ApexClass.new("M#{record.class_name}", result))
      }

      apex_classes.each do |apex_class|
        apex_class.write @output_dir
      end

      package_xml_template = IO.read("#{ApexRumble.source_dir}/package.xml.erb")
      compiler = ERB.new(package_xml_template)
      result = compiler.result(binding)
      File.write("#{@output_dir}/package.xml", result)
    end

    private

    def records #@TODO: Parse from the schema_dir argument (assuming *.object XML metadata for now)
      schema_reader = SchemaReader.new(@schema_dir)
      schema_reader.records
    end

    def validate
      if !@schema_dir
        @schema_dir = DEFAULT_SCHEMA_DIR
        warn 'No salesforce object metadata directory provided. Assuming ' + @schema_dir
      end

      unless File.directory?(@schema_dir)
        raise "Directory #{@schema_dir} is not present"
      end

      if !@output_dir
        @output_dir = DEFAULT_OUTPUT_DIR
        warn 'No output directory provided. Assuming ' + @output_dir
      end
    end

  end

end

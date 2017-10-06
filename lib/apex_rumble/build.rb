require "erb"
require "fileutils"
require "apex_rumble/metadata/apex_class"
require "apex_rumble/metadata/schema_reader"
module ApexRumble

  DEFAULT_SCHEMA_DIR = './schema'
  DEFAULT_OUTPUT_DIR = './apex_bin'

  class Build

    def initialize(schema_dir: nil, output_dir: nil)
      @schema_dir = schema_dir || DEFAULT_SCHEMA_DIR
      @output_dir = output_dir || DEFAULT_OUTPUT_DIR
    end

    def run
      apex_classes = []
      FileUtils::mkdir_p "#{@output_dir}/classes"

      records = SchemaReader.new(@schema_dir).records

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
        puts file_name
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
  end

end

require "erb"
require "fileutils"
require "apex_rumble/metadata/apex_class"
require "apex_rumble/metadata/sobject"
require "apex_rumble/metadata/custom_field"
module ApexRumble

  DEFAULT_SCHEMA_DIR = './src/objects'
  DEFAULT_OUTPUT_DIR = './apex_bin'

  class Build

    def initialize(schema_dir, output_dir)
      @schema_dir = schema_dir
      @output_dir = output_dir
      self.validate
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

    def records #@TODO: Parse from the schema_dir argument (assuming *.object XML metadata for now)
      [
        ApexRumble::SObject.new('Exception__c', [
          CustomField.new('Id', 'Id', true),
          CustomField.new('Name', 'String', true),
          CustomField.new('Account__c', 'Id', true),
          CustomField.new('Context__c', 'String', true),
          CustomField.new('Label__c', 'String', true),
          CustomField.new('MostRecentOccurrenceDate__c', 'DateTime', false),
          CustomField.new('Notes__c', 'String', true),
          CustomField.new('Occurrences__c', 'Decimal', false),
          CustomField.new('UniqueName__c', 'String', true)
        ]),
        ApexRumble::SObject.new('Occurrence__c', [
          CustomField.new('Id', 'Id', true),
          CustomField.new('Name', 'String', true),
          CustomField.new('Cause__c', 'String', true),
          CustomField.new('Exception__c', 'Id', true),
          CustomField.new('JobId__c', 'String', true),
          CustomField.new('Message__c', 'String', true),
          CustomField.new('OccurrenceDate__c', 'DateTime', true),
          CustomField.new('OrganizationId__c', 'String', true),
          CustomField.new('Sandbox__c', 'Boolean', true),
          CustomField.new('Stacktrace__c', 'String', true),
          CustomField.new('UserId__c', 'String', true)
        ])
      ]
    end

    def run
      # hard code some sobjects for. In the future these should be worked out in an intelligent fashion
      apex_classes = []
      FileUtils::mkdir_p "#{@output_dir}/classes"
      staticClasses = Dir.glob("#{ApexRumble.source_dir}/api/*.cls")
      staticClasses.each { |file_name|
        content = IO.read(file_name)
        class_name = File.basename(file_name, '.cls')
        apex_classes.push(ApexClass.new(class_name, content))
      }
      dynamicClasses = Dir.glob("#{ApexRumble.source_dir}/api/*.cls.erb")
      dynamicClasses.each { |file_name|
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

      self.records.each { |record|
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

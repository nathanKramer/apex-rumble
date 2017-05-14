require "apex_rumble/version"
require "apex_rumble/apex_class"
require "apex_rumble/metadata/sobject"
require "apex_rumble/metadata/custom_field"
require "erb"
require "fileutils"

class String
  def uncapitalize
    self[0, 1].downcase + self[1..-1]
  end
end

module ApexRumble
  def self.root
    File.dirname __dir__
  end

  def self.source_dir
    "#{ApexRumble.root}/lib/apex_rumble/apex_src"
  end

  def self.output_dir
    "#{ApexRumble.root}/apex_bin"
  end

  def self.build

    # hard code some sobjects for. In the future these should be worked out in an intelligent fashion
    records = [
      ApexRumble::SObject.new('Contact', [
        CustomField.new('Id', 'Id', true),
        CustomField.new('Name', 'String', true),
        CustomField.new('Email', 'String', true)
      ]),
      ApexRumble::SObject.new('My_Custom_ObjectWith_Crappy_Naming__c', [
        CustomField.new('Id', 'Id', true),
        CustomField.new('My_Custom_Field__c', 'String', true)
      ])
    ]

    apex_classes = []
    FileUtils::mkdir_p "#{ApexRumble.output_dir}/classes"
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
    records.each { |record|
      compiler = ERB.new(templates[:model_base])
      result = compiler.result(binding)
      apex_classes.push(ApexClass.new("Rumble#{record.class_name}", result))

      compiler = ERB.new(templates[:model])
      result = compiler.result(binding)
      apex_classes.push(ApexClass.new("M#{record.class_name}", result))
    }

    apex_classes.each do |apex_class|
      apex_class.write
    end

    package_xml_template = IO.read("#{ApexRumble.source_dir}/package.xml.erb")
    compiler = ERB.new(package_xml_template)
    result = compiler.result(binding)
    File.write("#{ApexRumble.output_dir}/package.xml", result)
  end
end

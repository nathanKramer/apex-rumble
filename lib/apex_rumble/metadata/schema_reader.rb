require 'nokogiri'
require 'apex_rumble/metadata/sobject'
require 'apex_rumble/metadata/custom_field'

module ApexRumble

  class SchemaReader

    TYPE_MAP = {
      Picklist: 'String',
      Text: 'String',
      LongTextArea: 'String',
      Lookup: 'Id',
      DateTime: 'DateTime',
      MultiselectPicklist: 'String'
    }

    def initialize(schema_dir)
      @schema_dir = schema_dir
    end

    def records
      records = []
      object_files = Dir.glob("#{@schema_dir}/*.object")
      object_files.each do |object_file|
        object_name = File.basename(object_file, '.object')
        fields = []

        object_xml = Nokogiri::XML(File.open(object_file))
        field_metadata = object_xml.css('fields')

        # For now, assume that Id and Name are present on all objects, since they're not present in object metadata
        fields.push CustomField.new('Id', 'Id', true)
        fields.push CustomField.new('Name', 'String', true)

        field_metadata.each do |field|
          writeable = field.css('formula').empty? || field.css('summarizedField').empty? || false

          salesforce_type = field.css('type').first.content
          apex_type = TYPE_MAP[salesforce_type.to_sym]

          if apex_type
            fields.push(
              CustomField.new(
                field.css('fullName').first.content,
                apex_type,
                writeable
              )
            )
          end
        end

        records.push SObject.new(
          object_name,
          fields
        )
      end
      records
    end

  end

end

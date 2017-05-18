require 'nokogiri'
require 'apex_rumble/metadata/sobject'
require 'apex_rumble/metadata/custom_field'

module ApexRumble

  class SchemaReader

    TYPE_MAP = {
      Checkbox: 'Boolean',
      Picklist: 'String',
      Text: 'String',
      TextArea: 'String',
      LongTextArea: 'String',
      Lookup: 'Id',
      DateTime: 'DateTime',
      MasterDetail: 'Id',
      MultiselectPicklist: 'String'
    }

    SUMMARY_OPERATION_MAP = {
      max: 'Decimal',
      count: 'Decimal'
    }

    def initialize(schema_dir)
      @objects = Hash.new
      Dir.glob("#{schema_dir}/*.object").each do |object_file|
        object_name = File.basename(object_file, '.object')
        object_xml = Nokogiri::XML(File.open(object_file))

        @objects[object_name] = object_xml.css('fields')
      end

      if @objects.empty?
        raise "No objects found in #{schema_dir}. Check that you have valid object metadata there."
      end
    end

    def records
      records = []
      index_schema.each do |object_name, fields|
        records.push SObject.new(
          object_name,
          fields.values
        )
      end
      records
    end

    private

    def index_schema
      schema = Hash.new
      summary_fields_to_qualify = Hash.new

      @objects.each do |object_name, fields_xml|
        summary_fields = fields_xml.select do |field|
          field.css('summarizedField').any?
        end
        summary_fields_to_qualify[object_name] = summary_fields
        schema[object_name] = parse_fields(fields_xml.reject { |field| summary_fields.include? field })
      end

      summary_fields_to_qualify.each do |object_name, fields_xml|
        fields_xml.each do |field_xml|
          field_name = field_xml.css('fullName').first.content
          summarized_field_path = field_xml.css('summarizedField').first.content
          related_object, summarized_field_name = summarized_field_path.split('.')
          schema[object_name][field_name] = CustomField.new(
            field_name,
            schema[related_object][summarized_field_name].type,
            false
          )
        end
      end

      schema
    end

    def parse_fields(fields_xml)
      fields = Hash.new
      # For now, assume that Id and Name are present on all objects, since they're not present in object metadata
      fields['Id'] = CustomField.new('Id', 'Id', true)
      fields['Name'] = CustomField.new('Name', 'String', true)

      fields_xml.each do |field|
        type = field.css('type')
        salesforce_type = 'Object'
        if type.any?
          salesforce_type = type.first.content
        end

        if field.css('summarizedField').empty?
          writeable = field.css('formula').empty?

          apex_type = TYPE_MAP.fetch(salesforce_type.to_sym, 'Object')

          summary_operation = field.css('summaryOperation')
          if summary_operation.any?
            writeable = false
            operation = summary_operation.first.content
            apex_type = SUMMARY_OPERATION_MAP.fetch(operation.to_sym, 'Object')
          end

          field_name = field.css('fullName').first.content
          fields[field_name] = CustomField.new(
            field_name,
            apex_type,
            writeable
          )
        end
      end

      fields
    end
  end
end

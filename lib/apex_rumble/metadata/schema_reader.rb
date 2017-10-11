require 'json'
require 'apex_rumble/metadata/sobject'
require 'apex_rumble/metadata/custom_field'

module ApexRumble

  class SchemaReader

    TYPE_MAP = {
      'currency' => 'Double',
      'email' => 'String',
      'reference' => 'Id',
      'int' => 'Integer',
      'phone' => 'String',
      'percent' => 'Decimal',
      'picklist' => 'String',
      'textarea' => 'String',
      'url' => 'String'
    }

    def initialize(schema_dir)
      @objects = []
      Dir.glob("#{schema_dir}/*.json").each do |object_file|
        @objects.push(JSON.parse(File.open(object_file).read))
      end

      if @objects.empty?
        raise "No schema found in #{schema_dir}. Check that you have valid SObject JSON there."
      end
    end

    def records
      records = @objects.reduce([]) { |memo, object|
        memo.push decorate_object(object)
        memo
      }
      records
    end

    private

    def decorate_object(object)
      object['fields'] = object['fields'].map do |field|
        field['apex_type'] = TYPE_MAP[field['type']] || field['type'].capitalize
        CustomField.new(field)
      end
      SObject.new(object)
    end

    def index_schema
      schema = Hash.new

      @objects.values.each do |object_name, object|
        schema[object_name] = object
      end

      schema
    end
  end
end

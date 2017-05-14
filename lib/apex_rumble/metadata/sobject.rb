module ApexRumble

  class SObject

    attr_reader :class_name
    attr_reader :fields
    attr_reader :api_name

    def initialize(type, fields)
      @api_name = type
      @class_name = type.gsub('__c', '').gsub('_', '')
      @fields = fields
    end
  end

end

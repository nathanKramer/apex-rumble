module ApexRumble

  class SObject

    attr_reader :class_name
    attr_reader :fields
    attr_reader :api_name

    def initialize(description)
      @api_name = description['name']
      @class_name = @api_name.gsub('__c', '').gsub('_', '')
      @fields = description['fields']
      @description = description
    end
  end

end

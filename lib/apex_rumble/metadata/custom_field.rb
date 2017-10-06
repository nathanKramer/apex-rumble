module ApexRumble

  class CustomField

    attr_reader :name
    attr_reader :property_name
    attr_reader :type

    def initialize(description)
      @name = description['name']
      @property_name = @name.uncapitalize.gsub('__c', '').gsub('_', '')
      @type = description['apex_type']
      @writeable = description['updateable']
      @description = description
    end

    def writeable?
      @writeable
    end
  end

end

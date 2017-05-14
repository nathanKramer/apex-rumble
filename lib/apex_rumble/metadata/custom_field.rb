module ApexRumble

  class CustomField

    attr_reader :name
    attr_reader :property_name
    attr_reader :type

    def initialize(field_name, type, writeable)
      @name = field_name
      @property_name = field_name.uncapitalize.gsub('__c', '').gsub('_', '')
      @type = type
      @writeable = writeable
    end

    def writeable?
      @writeable
    end
  end

end

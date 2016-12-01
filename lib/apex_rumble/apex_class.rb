require 'erb'

module ApexRumble
  class ApexClassGenerator
    def initialize(name='DefaultName', visibility='public', contents='// Your code here')
      @name = name
      @visibility = visibility
      @contents = contents

      @output = ''
    end

    def outputToFile
      b = binding
      ERB.new('<%= @visibility %> class <%= @name %> { <%= @contents %> }', 0, '', '@output').result b
      @output
    end
  end
end

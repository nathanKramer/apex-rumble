require "spec_helper"

describe ApexRumble do
  it "has a version number" do
    expect(ApexRumble::VERSION).not_to be nil
  end

  describe ApexRumble::ApexClassGenerator do
    it "can be constructed" do
      expect(ApexRumble::ApexClassGenerator.new()).not_to be nil
    end

    describe '#outputToFile' do
      it "can generate a string" do
        generatedClass = ApexRumble::ApexClassGenerator.new(
          name = 'ExampleClass',
          visibility = 'public',
          contents = '// This is an example'
        )
        expect(generatedClass.outputToFile).to eq 'public class ExampleClass { // This is an example }'
      end
    end
  end
end

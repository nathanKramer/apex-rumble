require "spec_helper"
require "pathname"

describe ApexRumble do
  PWD = Pathname(__dir__)
  SPECIFICATION_DIR = PWD.join 'specification'
  SCHEMA_DIR = PWD.join 'mock_metadata'
  OUTPUT_DIR = PWD.join 'spec_bin'

  it "has a version number" do
    expect(ApexRumble::VERSION).not_to be nil
  end

  describe ApexRumble::Build do
    it "generates code that matches our specifications exactly" do
      build = ApexRumble::Build.new(schema_dir: SCHEMA_DIR, output_dir: OUTPUT_DIR)
      build.run

      # Check that the two directories _look_ the same in terms of folder names and file names.
      expected = Dir.glob(SPECIFICATION_DIR.join('**/*'))
      actual = Dir.glob(OUTPUT_DIR.join('**/*'))

      expectedDir = expected.map { |path| File.basename path }
      actualDir = actual.map { |path| File.basename path }

      expect(actualDir).to eq expectedDir

      # Check file contents
      expected.each_with_index { |expectedFile, index|
        if Pathname(expectedFile).file?
          actualFile = actual[index]
          expect(IO.read(expectedFile)).to eq IO.read(actualFile)
        else
          warn "Skipping #{expectedFile} because it is not a file"
        end
      }
    end
  end
end

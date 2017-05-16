require "pathname"
module ApexRumble
  class HelpCommand
    HELP_DIR = Pathname(__dir__).join('help')
    DEFAULT_FILE_NAME = 'usage'

    def self.for(command)
      help_file = find(command) || default
      help_file.read
    end

    def self.default
      find(DEFAULT_FILE_NAME)
    end

    def self.find(help_file_name)
      pathname = HELP_DIR.join(help_file_name || DEFAULT_FILE_NAME)
      puts pathname.to_s
      pathname if pathname.exist?
    end
  end
end

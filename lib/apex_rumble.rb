require "apex_rumble/version"
require "apex_rumble/build"
require "apex_rumble/help_command"

class String
  def uncapitalize
    self[0, 1].downcase + self[1..-1]
  end
end

module ApexRumble
  def self.root
    File.dirname __dir__
  end

  def self.source_dir
    "#{ApexRumble.root}/lib/apex_rumble/apex_src"
  end
end

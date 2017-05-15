require "apex_rumble/version"
require "apex_rumble/build"

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

  def self.output_dir
    "#{ApexRumble.root}/apex_bin"
  end

  def self.build
    rumble_build = Build.new('src/objects', ApexRumble.output_dir)
    rumble_build.run
  end
end

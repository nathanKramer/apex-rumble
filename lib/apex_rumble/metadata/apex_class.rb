module ApexRumble

class ApexClass

  attr_reader :name
  attr_reader :content

  def initialize(name, content)
    @name = name
    @content = content
  end

  def class_name
    "#{name}.cls"
  end

  def write
    class_meta = "#{ApexRumble.root}/lib/apex_rumble/apex_src/Generic.cls-meta.xml"
    File.write("#{ApexRumble.output_dir}/classes/#{self.class_name}", @content)
    FileUtils.cp class_meta, "#{ApexRumble.output_dir}/classes/#{@name}.cls-meta.xml"
  end

end

end

class Mapping
  
  private_class_method :new
  @@singleton = nil

  attr_accessor :mappings

  def initialize
    @mappings = []
  end

  def Mapping.get_instance 
    @@singleton = new unless @@singleton
    @@singleton
  end

  def add_mapping(regexp, &proc)
    @mappings << [regexp, proc]
    nil
  end

  def files_matching(regexp)
    matching_files = []
    Dir.glob('**/*') do |file|
      if file =~ regexp
        matching_files << file
      end
    end
    matching_files
  end

end

class Device
  attr_reader :url, :environment, :behaviors
  
  def initialize(name, behaviors)
    @environment ||= []
    @url = url_from_name(name) 
    @behaviors ||= []
    add_behaviors(behaviors)
  end

  def listen
    environment
  end

  def present 
    @server = DRb.start_service(@url, self)
  end


  def to_json
    behaviors.to_json
  end
  
  private

  def add_behaviors(names)
    names.each do |name|
      @behaviors << Behavior.new(name)
    end
  end
  
  def url_from_name(name)
    "druby://#{ name }:1234"
  end
end

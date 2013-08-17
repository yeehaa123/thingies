class Device
  attr_reader :url, :behaviors
  
  def initialize(url, behaviors)
    @device_list ||= []
    @url = "druby://#{ url }:1234"
    @behaviors ||= []
    add_behaviors(behaviors)
  end

  def listen
    @device_list
  end

  def present 
    true
  end

  def register_device(url)
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
end



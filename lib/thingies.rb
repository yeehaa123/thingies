require 'drb/drb'

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
    true
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

class Hub < Device

  def register_device(name)
    url = url_from_name(name)
    device = DRbObject.new_with_uri(url)
    @environment << device
    device
  end
end

class Server < Device


end


Behavior = Struct.new(:name)

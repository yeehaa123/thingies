class Device
  attr_reader :url, :environment, :interactions
  
  def initialize(name, interactions)
    @environment ||= []
    @url = url_from_name(name) 
    @interactions ||= []
    add_interactions(interactions)
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

  def add_interactions(names)
    names.each do |name|
      @interactions << Interaction.new(name)
    end
  end
  
  def url_from_name(name)
    "druby://#{ name }:1234"
  end
end

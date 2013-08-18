class Hub < Device
  attr_reader :environment
  def initialize(name, behaviors)
    super
    @environment ||= Environment.new
  end

  def register_device(name)
    url = url_from_name(name)
    device = DRbObject.new_with_uri(url)
    @environment.devices << device
    device
  end
end

class Environment
  attr_reader :behaviors, :devices

  def initialize
    @devices ||= []
    @behaviors ||= []
  end
end

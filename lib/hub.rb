class Hub < Device

  def register_device(name)
    url = url_from_name(name)
    device = DRbObject.new_with_uri(url)
    @environment << device
    device
  end
end


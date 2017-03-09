class String
  # Method to check picture params is a picture
  def like_base64?
    self.length % 4 == 0 && self =~ /^[A-Za-z0-9+\/=]+\Z/
  end
end

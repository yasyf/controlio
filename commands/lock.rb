class Lock
  def initialize(*args)
  end

  def go
    `/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend`
  end

  def respond
    "Your screen has been locked!"
  end

  def is_media
    false
  end

  def matches
    ['lock']
  end
end

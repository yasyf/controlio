class Lock
  def initialize(*args)
  end

  def go
    `/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend`
  end

  def respond
    "Your screen has been locked!"
  end

  def media?
    false
  end

  def matches
    ['lock', 'lock my computer', 'lock my screen']
  end
end

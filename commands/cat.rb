class Cat
  def initialize(*args)
  end

  def go
    `open 'http://www.youtube.com/watch?v=QH2-TGUlwu4'`
  end

  def respond
    "Nyan Nyan Nyan Nyan Nyan Nyan Nyan..."
  end

  def media?
    false
  end

  def matches
    ['cat', 'cat mit', 'nyan']
  end
end

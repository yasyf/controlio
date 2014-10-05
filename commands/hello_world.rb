class HelloWorld
  def initialize(*args)
  end

  def go
    `say "Hello, World!"`
  end

  def respond
    "Hello, World!"
  end

  def media?
    false
  end

  def matches
    ['hw', 'hello world']
  end
end

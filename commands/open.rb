class Open
  def initialize(*args)
    @url = args[0...-1].join(' ').strip
  end

  def go
    `open '#{@url}'`
  end

  def respond
    ""
  end

  def media?
    false
  end

  def matches
    ['open']
  end
end

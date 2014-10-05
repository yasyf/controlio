class Say
  def initialize(*args)
    @text = args[0...-1].join(' ')
  end

  def go
    `say #{@text}`
  end

  def respond
    nil
  end

  def media?
    false
  end

  def matches
    ['say']
  end
end

class Say
  def initialize(*args)
    @text = args.first
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

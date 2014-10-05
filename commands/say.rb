class Say
  def initialize(*args)
    @text = args.to_a.first
  end

  def go
    `say #{@text}`
  end

  def respond
    nil
  end

  def is_media
    false
  end

  def matches
    ['say']
  end
end

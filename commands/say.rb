class Say
  def initialize(args, settings)
    @text = args.join(' ')
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

  def self.matches
    ['say']
  end
end

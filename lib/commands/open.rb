class Open
  def initialize(args, settings)
    @url = args.join(' ').strip
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

  def self.matches
    ['open']
  end
end

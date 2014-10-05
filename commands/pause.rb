class Pause
  def initialize(*args)
    @app = args.length > 1 ? args.first : "Rdio"
  end

  def go
    `osascript -e 'tell application "#{@app}" to pause'`
  end

  def respond
    ""
  end

  def media?
    false
  end

  def matches
    ['pause', 'pause my music']
  end
end

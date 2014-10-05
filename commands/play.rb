class Play
  def initialize(*args)
    @app = args.length > 1 ? args.first : "Rdio"
  end

  def go
    `osascript -e 'tell application "#{@app}" to launch'`
    sleep 1
    `osascript -e 'tell application "#{@app}" to play'`
  end

  def respond
    "Now playing #{`osascript -e 'tell application "#{@app}" to get the name of the current track'`}".chomp rescue ""
  end

  def media?
    false
  end

  def matches
    ['play']
  end
end

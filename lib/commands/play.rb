module Commands
  class Play
    def initialize(args, settings)
      @app = args.first || settings.get('default_player')
    end

    def go
      `osascript -e 'tell application "#{@app}" to launch'`
      sleep 1
      `osascript -e 'tell application "#{@app}" to play'`
    end

    def respond
      "Now playing: #{`osascript -e 'tell application "#{@app}" to get the name of the current track'`}".chomp rescue ""
    end

    def media?
      false
    end

    def self.matches
      ['play', 'play my music']
    end
  end
end

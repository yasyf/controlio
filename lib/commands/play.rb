require "helpers/player"

module Commands
  class Play
    def initialize(args, settings)
      @app = args.first || Helpers::Player.to_s || settings.get('default_player')
    end

    def go
      `osascript -e 'tell application "#{@app}" to launch'`
      sleep 1.5
      `osascript -e 'tell application "#{@app}" to play'`
    end

    def respond
      sleep 3.5
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

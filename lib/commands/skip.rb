module Commands
  class Skip
    def initialize(args, settings)
      @app = args.first || settings['default_player']
    end

    def go
      `osascript -e 'tell application "#{@app}" to next track'`
    end

    def respond
      "Now playing: #{`osascript -e 'tell application "#{@app}" to get the name of the current track'`}".chomp rescue ""
    end

    def media?
      false
    end

    def self.matches
      ['skip', 'skip this song', 'next', 'next song']
    end
  end
end

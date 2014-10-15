module Commands
  class Pause
    def initialize(args, settings)
      @app = args.first || settings['default_player']
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

    def self.matches
      ['pause', 'pause my music']
    end
  end
end

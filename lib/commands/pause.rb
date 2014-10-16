require "helpers/player"

module Commands
  class Pause
    def initialize(args, settings)
      @app = args.first || Helpers::Player.to_s || settings.get('default_player')
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

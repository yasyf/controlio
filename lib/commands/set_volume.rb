module Commands
  class SetVolume
    def initialize(args, settings)
      @level = args.first
    end

    def go
      `osascript -e 'set volume output volume #{@level}'`
    end

    def respond
      "Volume is now #{@level}"
    end

    def media?
      false
    end

    def self.matches
      ['set volume']
    end
  end
end

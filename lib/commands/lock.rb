module Commands
  class Lock
    def initialize(args, settings)
    end

    def go
      `/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend`
    end

    def respond
      "Your screen has been locked!"
    end

    def media?
      false
    end

    def self.matches
      ['lock', 'lock my computer', 'lock my screen']
    end
  end
end

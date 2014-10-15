module Commands
  class Cat
    def initialize(args, settings)
    end

    def go
      `open 'http://www.youtube.com/watch?v=QH2-TGUlwu4'`
    end

    def respond
      "Nyan Nyan Nyan Nyan Nyan Nyan Nyan..."
    end

    def media?
      false
    end

    def self.matches
      ['cat', 'cat mit', 'nyan']
    end
  end
end

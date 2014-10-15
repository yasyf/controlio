module Commands
  class HelloWorld
    def initialize(args, settings)
    end

    def go
      `say "Hello, World!"`
    end

    def respond
      "Hello, World!"
    end

    def media?
      false
    end

    def self.matches
      ['hw', 'hello world']
    end
  end
end

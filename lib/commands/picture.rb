require 'rest_client'

module Commands
  class Picture
    FILE_LOCATION = "/tmp/tmp.jpg"

    def initialize(args, settings)
      @api_root = settings.get('api_root')
    end

    def go
      `imagesnap -q #{FILE_LOCATION}`
      response = RestClient.post "#{@api_root}/upload", file: File.new(FILE_LOCATION, 'rb')
      @url = JSON.load(response)['url']
    end

    def respond
      @url
    end

    def media?
      true
    end

    def self.matches
      ['picture', 'snap']
    end
  end
end

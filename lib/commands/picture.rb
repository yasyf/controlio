require 'rest_client'
require 'tempfile'

module Commands
  class Picture

    def initialize(args, settings)
      @api_root = settings.get('api_root')
      @file = Tempfile.new(['picture', '.jpg'])
    end

    def go
      `#{File.expand_path("#{File.dirname(__FILE__)}/../../sbin/controlio-imagesnap")} -q #{@file.path}`
      response = RestClient.post "#{@api_root}/upload", file: File.new(@file.path, 'rb')
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

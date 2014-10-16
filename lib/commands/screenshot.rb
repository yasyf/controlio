require 'rest_client'
require 'tempfile'

module Commands
  class Screenshot

    def initialize(args, settings)
      @api_root = settings.get('api_root')
      @file = Tempfile.new(['screenshot', '.jpg'])
    end

    def go
      `screencapture -t jpg -x #{@file.path}`
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
      ['screenshot']
    end
  end
end

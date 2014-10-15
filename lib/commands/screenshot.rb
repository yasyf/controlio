require 'rest_client'

class Screenshot
  FILE_LOCATION = "/tmp/tmp.jpg"

  def initialize(args, settings)
    @api_root = args.last
  end

  def go
    `screencapture -t jpg -x #{FILE_LOCATION}`
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
    ['screenshot']
  end
end

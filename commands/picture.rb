require 'rest_client'

class Picture
  FILE_LOCATION = "/tmp/tmp.jpg"

  def initialize(*args)
    @api_root = args.last
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

  def matches
    ['picture', 'snap']
  end
end

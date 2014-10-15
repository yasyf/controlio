require "controlio/client"

module Controlio
  def self.start
    client = Client.new
    client.go
  end
end

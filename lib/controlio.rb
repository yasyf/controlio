require "controlio/client"
require "controlio/settings"

module Controlio
  def self.start
    client = Client.new
    client.go
  end

  def self.setup(force=false)
    begin
      File.delete File.expand_path("~/.controlio.json") if force
    rescue
    end
    settings = Settings.new
    exit
  end
end

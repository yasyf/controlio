require 'json'
require 'rest_client'
require 'active_support/all'

class Server
  API_ROOT = 'http://ym-remote-control-web.herokuapp.com'

  def initialize
    authorize
    generate_command_mappings
  end

  def go
    loop do
      check_for_commands.each do |c|
        command, *args = c['message'].split(':')
        klass = @mappings[command.downcase]
        if klass.present?
          puts "Running #{klass}"
          instance = klass.new(*args, API_ROOT)
          instance.go
          send instance.respond, instance.media?
        else
          send "That command was not found!"
        end
        destroy c['_id']
      end
      sleep 1
    end
  end

  private

  def authorize
    @api_key = begin File.read(File.expand_path("~/.remote_control_key")).chomp rescue throw "No API key found!" end
  end

  def send(message, media=false)
    if media
      options = {key: @api_key, media_url: message}
    else
      options = {key: @api_key, message: message}
    end
    RestClient.post("#{API_ROOT}/send", options) if message.present?
  end

  def destroy(id)
    RestClient.post "#{API_ROOT}/destroy/#{id}", key: @api_key
  end

  def check_for_commands
    JSON.load(RestClient.get("#{API_ROOT}/poll?key=#{@api_key}"))['commands']
  end

  def generate_command_mappings
    @mappings = {}
    Dir['commands/*.rb'].each do |file|
      require_relative file
      klass = file.split("/").last.split('.').first.camelize.constantize
      klass.new.matches.each do |match|
        @mappings[match] = klass
      end
    end
  end
end

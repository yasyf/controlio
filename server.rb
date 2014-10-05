require 'json'
require 'rest_client'
require 'active_support/all'

class Server
  API_ROOT = 'http://0.0.0.0:5000'

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
          instance = klass.new(args)
          instance.go
          send instance.respond
        else
          send "That command was not found!"
        end
        destroy c['_id']
      end
      sleep 5
    end
  end

  private

  def authorize
    @api_key = begin File.read(File.expand_path("~/.remote_control_key")).chomp rescue throw "No API key found!" end
  end

  def send(message)
    RestClient.post("#{API_ROOT}/send", key: @api_key, message: message) if message.present?
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

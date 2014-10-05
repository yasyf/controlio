require 'json'
require 'rest_client'
require 'active_support'
require 'active_support/inflector'

class Server
  API_ROOT = 'http://0.0.0.0:5000'

  def initialize
    authorize
  end

  private

  def go
    loop do
      commands = check_for_commands
      commands.each do |c|
        command, *args = c['message'].split(':')
        klass = command_mappings[command.downcase]
        if klass.present?
          instance = klass.new(args)
          instance.go
          send(instance.respond)
        end
        destroy(c['_id'])
      end
      sleep 5
    end
  end

  def authorize
    self.key = begin File.read("~/.remote_control_key") rescue throw "No API key found!" end
  end

  def send(message)
    RestClient.post("#{API_ROOT}/send", key: key, message: message) if message.present?
  end

  def destroy(id)
    RestClient.post "#{API_ROOT}/destroy/#{id}", key: key
  end

  def check_for_commands
    JSON.load RestClient.get("#{API_ROOT}/poll?key=#{key}")
  end

  def command_mappings
    return self.mappings if self.mappings.present?
    self.mappings = {}
    Dir['commands/*.rb'].each do |file|
      require file
      klass = file.split("/").last.camelize.constantize
      klass.new.matches.each do |match|
        self.mappings[match] = klass
      end
    end
  end
end

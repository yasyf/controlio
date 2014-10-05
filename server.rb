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
        matched = false
        command_options(c).each do |split|
          command, *args = split
          klass = @mappings[command.downcase]
          if klass.present?
            puts "Running #{klass}"
            instance = klass.new(*args, API_ROOT)
            instance.go
            send instance.respond, instance.media?
            matched = true
            break
          end
        end
        unless matched
          send "Command '#{c['message']}' was not found!"
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

  def command_options(c)
    options = []
    options << c['message'].split(':')
    split_on_spaces = c['message'].split(' ')
    options << split_on_spaces
    (2...options.length).each do |i|
      options << [split_on_spaces[0...i].join(' ')] + split_on_spaces[i..-1]
    end
    options
  end

  def permutations
    ['', 'do ', 'take a ']
  end

  def generate_command_mappings
    @mappings = {}
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each do |file|
      require_relative file
      klass = file.split("/").last.split('.').first.camelize.constantize
      klass.new.matches.each do |match|
        permutations.each do |p|
          @mappings["#{p}#{match}"] = klass
        end
      end
    end
  end
end

Server.new.go

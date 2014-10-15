require 'json'
require 'rest_client'
require 'active_support/all'
require_relative 'settings'

class Server

  def initialize
    authorize
    generate_command_mappings!
  end

  def go
    loop do
      check_for_commands.each do |c|
        klass, args = command_options(c)
        if klass.present?
          puts "Running #{klass} (#{args})"
          instance = klass.new(args, @settings)
          instance.go
          send instance.respond, instance.media?
        else
          send "Command '#{c['message']}' was not found!"
        end
        destroy c['_id']
      end
      sleep 1
    end
  end

  private

  def authorize
    @settings = Settings.new
    @api_key = @settings.get('api_key')
    @api_root = @settings.get('api_root')
  end

  def send(message, media=false)
    if media
      options = {key: @api_key, media_url: message}
    else
      options = {key: @api_key, message: message}
    end
    RestClient.post("#{@api_root}/send", options) if message.present?
  end

  def destroy(id)
    RestClient.post "#{@api_root}/destroy/#{id}", key: @api_key
  end

  def check_for_commands
    JSON.load(RestClient.get("#{@api_root}/poll?key=#{@api_key}"))['commands']
  end

  def command_options(c)
    options = c['message'].downcase.split(' ')
    (1..options.length).each do |i|
      command = options.first(i).join(' ')
      return [@mappings[command], options[i..-1]] if @mappings.include? command
    end
    []
  end

  def prefixes
    ['']
  end

  def generate_command_mappings!
    @mappings = {}
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each do |file|
      require_relative file
      klass = file.split("/").last.split('.').first.camelize.constantize
      klass.matches.each do |match|
        prefixes.each do |p|
          @mappings["#{p}#{match}"] = klass
        end
      end
    end
  end
end

Server.new.go

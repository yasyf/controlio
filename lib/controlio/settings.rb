require 'json'
require 'rest_client'
require 'io/console'

module Controlio
  class Settings
    API_ROOT = ENV['API_ROOT'] || 'http://ym-remote-control-web.herokuapp.com'
    SETTINGS_FILE = File.expand_path "~/.controlio.json"

    def initialize
      @settings = (begin JSON.parse File.read(SETTINGS_FILE) rescue create_new_settings end).with_indifferent_access
    end

    def get(key)
      @settings[key]
    end

    def set(key, value)
      @settings[key] = value
      File.write SETTINGS_FILE, settings.to_json
    end

    private

    def create_new_settings
      settings = {api_root: API_ROOT}
      puts "Enter your phone number"
      number = gets.chomp
      if JSON.load(RestClient.get("#{API_ROOT}/check/#{number}"))['registered']
        key = nil
        while !key
          puts "Enter your password"
          password = STDIN.noecho(&:gets).chomp
          key = JSON.load(RestClient.get("#{API_ROOT}/key/#{number}?password=#{password}"))['key']
        end
      else
        puts "Pick a password"
        password = STDIN.noecho(&:gets).chomp
        key = JSON.load(RestClient.post("#{API_ROOT}/key/#{number}", password: password))['key']
      end
      puts "Successfuly authenticated!"
      settings[:api_key] = key
      File.write SETTINGS_FILE, settings.to_json
      settings
    end

  end
end

module Helpers
  class Player

    def self.app_names
      ["Spotify", "Rdio", "iTunes"]
    end

    def self.to_s
      app_names.each do |app|
        return "#{app}.app" if `ps aux | grep "#{app}"`.include? "#{app}.app"
      end
      nil
    end
  end
end

class Server
  def initialize
    authorize
  end

  private

  def authorize
    self.key = begin File.read("~/.remote_control_key") rescue throw "No API key found!" end
  end
end

class Type
  def initialize(args, settings)
    @keys = args.join(' ')
  end

  def go
    `osascript -e 'tell application "System Events" to keystroke "#{@keys}"'`
  end

  def respond
    "Your string has been typed!"
  end

  def media?
    false
  end

  def self.matches
    ['type']
  end
end

class Type
  def initialize(*args)
    @keys = args.first
  end

  def go
    `osascript -e 'tell application "System Events" to keystroke "#{@keys}"'`
  end

  def respond
    "Your string has been typed!"
  end

  def matches
    ['type']
  end
end

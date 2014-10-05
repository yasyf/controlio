class Type
  def initialize(*args)
    @keys = args[0...-1].join(' ')
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

  def matches
    ['type']
  end
end

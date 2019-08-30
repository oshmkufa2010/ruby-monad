require './state_t'
require './maybe'

class ParserCombinator < StateT.new(Maybe).state_class
  def run_parser(s)
    run(s)
  end

  def self.satisfy(&f)
    new do |s|
      if s == []
        []
      else
        x, *xs = s
        f.(x) ? Maybe.just([x, xs]) : Maybe.nothing
      end
    end
  end

  def self.char(ch)
    satisfy { |c| c == ch }
  end

  def self.string(str)
    if str == []
      unit([])
    else
      c, *cs = str
      self.for {
        x <= proc { ParserCombinator.char(c) }
        xs <= proc { ParserCombinator.string(cs) }
      }.yield { [x] + xs }
    end
  end
end

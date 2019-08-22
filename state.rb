require './monad'

class State
  include Monad

  def initialize(&f)
    @f = f
  end

  def run(s)
    @f.(s) 
  end

  def self.unit(a)
    new { |s| [a, s] }
  end

  def flat_map(&g)
    State.new do |s|
      a, ss = run(s)
      g.(a).run(ss)
    end
  end
end

class 

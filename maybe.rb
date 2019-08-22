require './monad'

class Maybe
  include Monad

  def self.just(a)
    @ins = Just.new(a)
  end

  def self.nothing
    @ins = Nothing.new 
  end

  def self.unit(a)
    just(a)
  end

  def flat_map(&f)
    @ins.flat_map(&f)
  end
end

class Just < Struct.new(:a)
  def flat_map(&f)
    f.(a)
  end
end

class Nothing
  def flat_map(&f)
    self
  end
end

# Maybe.for {
#   let(:x) { Maybe.just(1) }
#   let(:y) { Maybe.just(2) }
# }.yield { x + y } # => Just(3)

# Maybe.for {
#   let(:x) { Maybe.just(1) }
#   let(:y) { Maybe.nothing }
# }.yield { x + y } # => Nothing

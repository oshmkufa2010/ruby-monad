require './monad'

class Maybe
  include Monad

  def initialize(ins)
    @ins = ins
  end

  def self.just(a)
    new(Just.new(a))
  end

  def self.nothing
    new(Nothing.new)
  end

  def self.unit(a)
    just(a)
  end

  def flat_map(&f)
    case @ins
    when Just
      f.(@ins.a)
    when Nothing
      self
    end
  end

  def klass
    @ins.class
  end
end

class Just < Struct.new(:a)
end

class Nothing; end

# Maybe.for {
#   let(:x) { Maybe.just(1) }
#   let(:y) { Maybe.just(2) }
# }.yield { x + y } # => Just(3)

# Maybe.for {
#   let(:x) { Maybe.just(1) }
#   let(:y) { Maybe.nothing }
# }.yield { x + y } # => Nothing

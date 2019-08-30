require './monad'

class Identity
  include Monad

  def initialize(a)
    @a = a
  end

  def run
    @a
  end

  def self.unit(x)
    new(x)
  end

  def flat_map(&f)
    f.(@a)
  end
end

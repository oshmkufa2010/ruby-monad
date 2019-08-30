require './monad'

class StateT
  def initialize(m)
    @m = m
  end

  def state_class
    m = @m 

    Class.new do
      include Monad

      define_method :initialize do |&f|
        @f = f
      end
    
      define_method :run do |s|
        @f.(s) 
      end
    
      define_singleton_method :unit do |a|
        new { |s| m.unit([a, s]) }
      end
    
      define_method :flat_map do |&g|
        self.class.new do |sik-pay-activity|
          run(s).flat_map do |a, ss|
            g.(a).run(ss)
          end
        end
      end
    end

  end

end

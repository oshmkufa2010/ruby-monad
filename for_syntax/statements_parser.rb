module ForSyntax
  class StatementsParser
    def initialize
      @statements = []
    end

    def parse(for_proc) 
      instance_eval(&for_proc)
      @statements
    end

    def method_missing(method_name, *args)
      statements = @statements
      Class.new do
        define_method '<=' do |monad_proc|
          statements << [method_name.to_sym, monad_proc]
        end
      end.new
    end

    private

    def let(var_name, &monad_proc)
      @statements << [var_name, monad_proc]
    end
  end
end

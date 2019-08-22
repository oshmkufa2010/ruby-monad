require './for_syntax/env'

module ForSyntax
  class Syntax
    def initialize(monad_class, statements)
      @monad_class = monad_class
      @statements = statements
    end

    def yield(&yield_proc)
      monad_class = @monad_class
      unit_proc = proc { monad_class.unit(instance_eval(&yield_proc)) }
      Env.new.eval_statements(@statements, unit_proc)
    end
  end
end

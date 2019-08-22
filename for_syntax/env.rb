module ForSyntax
  class Env < Hash
    def eval_monad_proc(proc)
      each do |var_name, val|
        define_singleton_method var_name do val; end
      end

      instance_eval(&proc)
    end

    def eval_statements(statements, unit_proc)
      if statements == []  
        eval_monad_proc(unit_proc)
      else
        statement, *rest_statements = statements
        var_name, monad_proc = statement

        eval_monad_proc(monad_proc).flat_map do |x|
          merge(var_name => x).eval_statements(rest_statements, unit_proc)
        end
      end
    end
  end
end

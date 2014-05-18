module Sign
  class Signature
    attr_reader :sign, :args_constraints, :result_constraint

    def initialize sign
      @sign = sign
      generate_constraints
    end

    def match_args? args
      return false unless args.count == args_constraints.count
      args.zip(args_constraints).all? do |(arg, constraint)|
        constraint.match? arg
      end
    end

    def match_result? result
      result_constraint.match? result
    end

    private

    def generate_constraints
      *@args_constraints, @result_constraint = sign.split(/\s*(?:,|->)\s*/).map do |type_name|
        Constraint.new type_name
      end
    end
  end
end

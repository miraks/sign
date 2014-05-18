module Sign
  class Constraint
    attr_reader :type

    def initialize type_name
      @type = Object.const_get type_name
    end

    def match? arg
      arg.kind_of? type
    end
  end
end

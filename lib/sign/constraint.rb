module Sign
  class Constraint
    attr_reader :type, :strict
    alias :strict? :strict

    def initialize type_name
      @type = extract_type type_name
      set_attributes type_name
    end

    def match? arg
      if strict?
        arg.class == type
      else
        arg.kind_of? type
      end
    end

    private

    def extract_type type_name
      Object.const_get type_name.match(/[\w:]+/)[0]
    end

    def set_attributes type_name
      set_strictness type_name
    end

    def set_strictness type_name
      @strict = type_name.start_with? '!'
    end
  end
end

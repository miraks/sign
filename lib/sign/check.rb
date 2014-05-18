module Sign
  module Check
    def signature str
      @current_sign = str
    end
    alias :sign :signature

    def add_sign sign, method_name
      signature = Signature.new sign
      with_method_rename method_name do |old_method_name|
        define_method method_name do |*args|
          unless signature.match_args? args
            raise WrongType.new 'wrong argument type'
          end

          result = send old_method_name, *args

          unless signature.match_result? result
            raise WrongType.new 'wrong result type'
          end

          result
        end
      end
    end

    private

    def with_method_rename method_name
      new_method_name = "old_#{method_name}"
      alias_method new_method_name, method_name
      yield new_method_name
    end

    def method_added name
      return if @current_sign.nil?
      sign = @current_sign
      @current_sign = nil
      add_sign sign, name
    end
  end
end

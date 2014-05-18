require 'spec_helper'

describe "#signature" do
  before :each do
    class Foo
      extend Sign::Check
    end
  end

  after :each do
    Object.send :remove_const, :Foo
  end

  context "instance method" do
    context "method without arguments" do
      subject { -> { Foo.new.bar } }

      context "with correct signature" do
        before :each do
          class Foo
            sign 'Integer'
            def bar
              3
            end
          end
        end

        it "returns method result" do
          expect(subject.call).to eq 3
        end
      end

      context "with incorrect signature" do
        before :each do
          class Foo
            sign 'String'
            def bar
              3
            end
          end
        end

        it "raise error" do
          expect { Foo.new.bar }.to raise_error Sign::WrongType
        end
      end
    end

    context "method with one argument" do
      before :each do
        class Foo
          sign 'String -> Integer'
          def bar str
            str.length
          end
        end
      end

      describe "argument type check" do
        it "runs method and returns it result if arg passed check" do
          expect(Foo.new.bar('bar')).to eq 3
        end

        it "raises error if arg hasn't pass check" do
          expect { Foo.new.bar 3 }.to raise_error Sign::WrongType
        end
      end
    end

    context "method with multiple arguments" do
      before :each do
        class Foo
          sign 'String -> Integer -> Integer -> String'
          def bar str, int1, int2
            str + int1.to_s + int2.to_s
          end
        end
      end

      describe "arguments type check" do
        it "runs method and returns it result if all args passed check" do
          expect(Foo.new.bar 'bar', 1, 2).to eq 'bar12'
        end

        it "raises error if one of args hasn't pass check" do
          expect { Foo.new.bar 1, 2, 3 }.to raise_error Sign::WrongType
          expect { Foo.new.bar 'bar', 'foo', 3 }.to raise_error Sign::WrongType
          expect { Foo.new.bar 'bar', 2, [3] }.to raise_error Sign::WrongType
          expect { Foo.new.bar [1], 'bar', Object.new }.to raise_error Sign::WrongType
        end
      end
    end
  end
end

# Sign

Gives you ability to specify method signature that checked at runtime

## Installation

Add this line to your application's Gemfile:

    gem 'sign'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sign

## Usage

Extend your class or module with `Sign::Check`

```ruby
class MyClass
  extend Sign::Check
end
```

Now you should be able to specify methods signatures

```ruby
class MyClass
  extend Sign::Check

  sign 'String -> Integer'
  def str_length str
    str.length
  end

  sign 'String, Integer, Integer -> String'
  # You also can use Haskell-like type-signature
  # sign 'String -> Integer -> Integer -> String'
  def str_slice str, left, right
    33
  end

  # #kind_of? used internally so you can specify any class/module
  # from object ancestors chain
  sign 'Enumerable -> Array'
  def to_array enum
    enum.to_a
  end
end

MyClass.new.str_length 'string' # => 6
# Wrong argument type
MyClass.new.str_length 33 # => Sign::WrongType
# Wrong result type
MyClass.new.str_slice 'string', 1, 3 # => Sign::WrongType
```

Add bang symbol before type in order to make type check strict

```ruby
class Foo
end

class Bar < Foo
end

class MyClass
  sign '!Foo -> Foo'
  def get_foo foo
    Foo.new
  end
end

foo = Foo.new
MyClass.new.foo_foo foo # => foo
bar = Bar.new
MyClass.new.foo_foo bar # => Sign::WrongType
```

## In progress

* Add square-bracket support
* Add splat operator support
* Add class methods support
* Write more specs

## Contributing

1. Fork it ( https://github.com/miraks/sign/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Passw: Easy secure password generation for Ruby

`passw` generates flexible, secure passwords for your Ruby applications. 

Requirements
-----------------

It's recommend that you use Ruby 2.0.0 or higher.

Installation
-----------------

```
gem install passw
```

Or add it to your `Gemfile`: 

```
gem 'passw'
```

Getting Started
-----------------

```ruby
require 'passw'

Passw.generate(12) # => ^IUH91234la*

```

Available Options
-----------------

Wobbly supports the following tokens and combinations of them:

- 'lowercase' 
- 'uppercase' 
- 'symbols' 
- 'numbers'
- 'duplicates'

Examples
-----------------

```ruby

```

Running the tests
-----------------

To test the current stable version of `passw`, run:

```
rake test
```

License
-----------------

Please see [LICENSE](https://github.com/SeanNieuwoudt/passw/blob/master/LICENSE) for licensing details.

Author
-----------------

Sean Nieuwoudt, [@SeanNieuwoudt](https://twitter.com/seannieuwoudt) / [http://isean.co.za](http://isean.co.za)
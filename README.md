## Easy & secure password generation for Ruby

A Ruby Gem that allows you to generate secure passwords programmatically or via the terminal.

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

Passw supports the following options and combinations of them:

- `:lowercase`
- `:uppercase`
- `:symbols`
- `:numbers`
- `:duplicates`

Examples
-----------------

```ruby
# Generate a secure password of 12 characters in length
Passw.generate(12)

# Output => `|vwr8j5VV8W

# Options available for the password generation
Passw.generate(12, {
  lowercase:  true, # Allow lower case characters
  uppercase:  true, # Allow uppercase characters
  symbols:    true, # Allow symbols
  numbers:    true, # Allow numbers 
  duplicates: false  # Allow characters to be duplicated (less secure if true)	
})

# Outout => qU.b"fo+P>Wl
```

Executable
-----------------

This gem also includes an executable that can be called directly from the terminal:

```
passw <password length>
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
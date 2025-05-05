## Flexible and Secure Password Generation for Ruby

Passw is a Ruby gem for generating secure, customizable passwords programmatically or directly via the terminal. It offers advanced options for character type enforcement, exclusion lists, entropy-based strength assessment, and more.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/underwulf)

Requirements
-----------------
Ruby 2.7 or higher is recommended.

Installation
-----------------

```shell
gem install passw
```

Or add it to your `Gemfile`: 

```
gem 'passw'
```

Getting Started
-----------------
To generate a password, simply require passw and use the generate method:

```ruby
require 'passw'

# Generate a 12-character password
Passw.generate(12) # => e.g., ^IUH91234la*
```

Available Options
-----------------
Passw supports the following options and combinations of them:

- `length:` - Set the length of the password (default: `12`).
- `lowercase:` - Include lowercase letters (default: `true`).
- `uppercase:` - Include uppercase letters (default: `true`).
- `symbols:` - Include special characters (default: `true`).
- `numbers:` - Include numeric characters (default: `true`).
- `duplicates:` - Allow duplicate characters (default: `true`).
- `enforce_types:` - Ensure at least one of each selected character type (default: `true`).
- `avoid_sequences:` - Prevent sequential characters (e.g., abc, 123).
- `exclude:` - Exclude specific characters (e.g., O, 0, I, l).
- `min_length:` - Enforce a minimum password length (default: 8).
- `entropy:` - Calculate and display the password's entropy for strength assessment.

Examples
-----------------

### Basic Password Generation

```ruby
Passw.generate(12) # => e.g., |vwr8j5VV8W
```

### Advanced Usage with Options

```ruby
Passw.generate(12, {
  lowercase: true,       # Include lowercase letters
  uppercase: true,       # Include uppercase letters
  symbols: true,         # Include symbols
  numbers: true,         # Include numbers
  duplicates: false,     # No duplicate characters
  enforce_types: true,   # At least one of each type
  avoid_sequences: true, # No sequential characters
  exclude: ['O', '0', 'I', 'l'] # Exclude characters that may cause confusion
}) 
# => e.g., qU.b"fo+P>Wl
```

Command-Line Usage
-----------------
Passw includes a command-line executable for generating passwords directly from the terminal:

```
passw <password length>
```

For example:

```ruby
passw 12
```

### Advanced Options

The CLI supports additional options for fine-tuning the password. Here's the full list:

- `--lowercase`: Include lowercase letters (default: enabled).
- `--uppercase`: Include uppercase letters (default: enabled).
- `--symbols`: Include symbols (default: enabled).
- `--numbers`: Include numbers (default: enabled).
- `--no-duplicates`: Disallow duplicate characters in the password.
- `--enforce-types`: Ensure at least one of each selected character type (default: enabled).
- `--avoid-sequences`: Avoid sequential characters (e.g., `abc`, `123`).
- `--exclude` CHARS: Exclude specific characters, using a comma-separated list (e.g., O,0,I,l).
- `--min-length` LENGTH: Set a minimum password length (default: 8).

#### Examples

Generate a Password Without Symbols:

```bash
passw 12 --no-symbols
```

Generate a Password Excluding Specific Characters
```bash
passw 12 --exclude O,0,I,l
```

Generate a Password With No Duplicate Characters and No Sequential Characters
```bash
passw 12 --no-duplicates --avoid-sequences
```

### Help
For a full list of options, use:

```bash
passw --help
```

Running the tests
-----------------
To run the tests for `passw`, run:

```bash
rake test

# Running:
........

Finished in 0.000668s, 11976.0479 runs/s, 70359.2814 assertions/s.

8 runs, 47 assertions, 0 failures, 0 errors, 0 skips
```

License
-----------------
This project is licensed under the [GPL-3.0-or-later](https://github.com/sn/passw/blob/master/LICENSE) license. See LICENSE for details.

Author
-----------------
[github.com/sn](https://github.com/sn) 

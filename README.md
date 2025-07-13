## Flexible and Secure Password Generation for Ruby

Passw is a Ruby gem for generating secure, customizable passwords programmatically or directly via the terminal. It offers advanced options for character type enforcement, exclusion lists, entropy-based strength assessment, and cryptographically secure random generation.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/underwulf)

## Security Features

- **Cryptographically Secure**: Uses Ruby's `SecureRandom` for all random number generation
- **Input Validation**: Comprehensive validation prevents impossible constraint combinations
- **Constraint Enforcement**: Reliable enforcement of character type requirements
- **Entropy Calculation**: Real-time password strength assessment with entropy calculation

## Requirements
Ruby 2.7 or higher is recommended.

## Installation

```shell
gem install passw
```

Or add it to your `Gemfile`: 

```ruby
gem 'passw'
```

## Getting Started

To generate a password, simply require passw and use the generate method:

```ruby
require 'passw'

# Generate a 12-character password
result = Passw.generate(12)
puts result[:password]  # => e.g., "^IUH91234la*"
puts result[:entropy]   # => e.g., 72.45
puts result[:strength]  # => e.g., "Strong"
```

## Return Format

The `generate` method returns a hash with three keys:
- `:password` - The generated password string
- `:entropy` - The calculated entropy in bits (Float)
- `:strength` - Password strength assessment ("Very Weak", "Weak", "Reasonable", "Strong", "Very Strong")

## Available Options

Passw supports the following options and combinations:

- `lowercase:` - Include lowercase letters (default: `true`)
- `uppercase:` - Include uppercase letters (default: `true`)
- `symbols:` - Include special characters (default: `true`)
- `numbers:` - Include numeric characters (default: `true`)
- `duplicates:` - Allow duplicate characters (default: `true`)
- `enforce_types:` - Ensure at least one of each selected character type (default: `true`)
- `avoid_sequences:` - Prevent sequential/repeating characters (default: `true`)
- `exclude:` - Exclude specific characters (default: `[]`)
- `min_length:` - Enforce a minimum password length (default: `8`)

## Examples

### Basic Password Generation

```ruby
result = Passw.generate(12)
# => {
#      password: "|vwr8j5VV8W",
#      entropy: 71.1,
#      strength: "Strong"
#    }
```

### Advanced Usage with Options

```ruby
result = Passw.generate(16, {
  lowercase: true,       # Include lowercase letters
  uppercase: true,       # Include uppercase letters
  symbols: true,         # Include symbols
  numbers: true,         # Include numbers
  duplicates: false,     # No duplicate characters
  enforce_types: true,   # At least one of each type
  avoid_sequences: true, # No sequential characters
  exclude: ['O', '0', 'I', 'l'] # Exclude confusing characters
})

puts result[:password]  # => e.g., "qU.b\"fo+P>Wl9kR"
puts result[:entropy]   # => e.g., 89.2
puts result[:strength]  # => "Very Strong"
```

### High-Security Password

```ruby
# Generate a highly secure 20-character password
result = Passw.generate(20, {
  duplicates: false,
  avoid_sequences: true,
  exclude: ['O', '0', 'I', 'l', '1'] # Exclude visually similar characters
})

puts "Password: #{result[:password]}"
puts "Entropy: #{result[:entropy]} bits"
puts "Strength: #{result[:strength]}"
```

## Error Handling

The gem includes comprehensive error handling for invalid constraints:

```ruby
# This will raise Passw::InvalidConstraintsError
begin
  Passw.generate(10, {
    lowercase: false,
    uppercase: false, 
    symbols: false,
    numbers: false
  })
rescue Passw::InvalidConstraintsError => e
  puts "Invalid constraints: #{e.message}"
end

# This will raise ArgumentError
begin
  Passw.generate(-5)
rescue ArgumentError => e
  puts "Invalid length: #{e.message}"
end
```

## Command-Line Usage

Passw includes a command-line executable for generating passwords directly from the terminal:

```bash
passw <password_length>
```

For example:

```bash
passw 12
```

### Advanced CLI Options

The CLI supports additional options for fine-tuning the password:

- `--lowercase`: Include lowercase letters (default: enabled)
- `--uppercase`: Include uppercase letters (default: enabled)
- `--symbols`: Include symbols (default: enabled)
- `--numbers`: Include numbers (default: enabled)
- `--no-duplicates`: Disallow duplicate characters in the password
- `--enforce-types`: Ensure at least one of each selected character type (default: enabled)
- `--avoid-sequences`: Avoid sequential characters (e.g., `abc`, `123`)
- `--exclude` CHARS: Exclude specific characters, using a comma-separated list (e.g., O,0,I,l)
- `--min-length` LENGTH: Set a minimum password length (default: 8)

#### CLI Examples

Generate a Password Without Symbols:
```bash
passw 12 --no-symbols
```

Generate a Password Excluding Specific Characters:
```bash
passw 12 --exclude O,0,I,l
```

Generate a Password With No Duplicate Characters and No Sequential Characters:
```bash
passw 12 --no-duplicates --avoid-sequences
```

### Help
For a full list of options, use:

```bash
passw --help
```

## Running the Tests

To run the tests for `passw`:

```bash
rake test

# Running:
...........

Finished in 0.002438s, 4511.8950 runs/s, 29942.5759 assertions/s.

11 runs, 73 assertions, 0 failures, 0 errors, 0 skips
```

## Security Considerations

- All random number generation uses Ruby's `SecureRandom` for cryptographic security
- Password generation includes protection against infinite loops with constraint validation
- Character type enforcement is preserved even after shuffling
- Input validation prevents impossible constraint combinations

## License

This project is licensed under the [GPL-3.0-or-later](https://github.com/sn/passw/blob/master/LICENSE) license. See LICENSE for details.

## Author

[github.com/sn](https://github.com/sn)
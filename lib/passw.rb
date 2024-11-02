module Passw
  # Generate a password with specified options
  # Params:
  # +length+:: the length of the password
  # +options+:: a hash defining the attributes for the password
  def self.generate(length, options = {})
    defaults = {
      lowercase:        true,  # Allow lowercase characters
      uppercase:        true,  # Allow uppercase characters
      symbols:          true,  # Allow symbols
      numbers:          true,  # Allow numbers
      duplicates:       true,  # Allow duplicates
      enforce_types:    true,  # Ensure at least one of each selected character type
      avoid_sequences:  true,  # Avoid sequential/repeating characters
      exclude:          [],    # Characters to exclude from password
      min_length:       8      # Minimum password length
    }

    # Merge user options with defaults
    settings = defaults.merge(options)

    # Enforce minimum length
    length = [length.to_i, settings[:min_length]].max

    # Build character set based on options
    character_set = build_character_set(settings)
    return '' if character_set.empty?

    # Filter out excluded characters
    character_set -= settings[:exclude]

    # Generate the password with necessary character types enforced
    password = generate_password(character_set, length, settings)

    # Calculate and display password entropy
    entropy = calculate_entropy(character_set.size, length)

    password.shuffle.join
  end

  private

  # Build the character set based on the specified options
  def self.build_character_set(settings)
    character_set = []
    character_set += lowercase if settings[:lowercase]
    character_set += uppercase if settings[:uppercase]
    character_set += symbols   if settings[:symbols]
    character_set += numbers   if settings[:numbers]
    character_set
  end

  # Generate the password based on options
  def self.generate_password(character_set, length, settings)
    password = []

    # Ensure at least one character from each type if enforce_types is enabled
    if settings[:enforce_types]
      password << lowercase.sample if settings[:lowercase]
      password << uppercase.sample if settings[:uppercase]
      password << symbols.sample if settings[:symbols]
      password << numbers.sample if settings[:numbers]
    end

    # Fill the rest of the password
    while password.length < length
      candidate = character_set.sample

      if settings[:duplicates]
        password << candidate
      else
        # Avoid duplicates if duplicates option is false
        next if password.include?(candidate)
        password << candidate
      end

      # Avoid sequences/repeating characters if avoid_sequences is true
      if settings[:avoid_sequences] && password.size > 1
        next_char = password[-1]
        prev_char = password[-2]
        if next_char.ord == prev_char.ord + 1 || next_char.ord == prev_char.ord - 1
          password.pop
        end
      end
    end
    password
  end

  # Entropy calculation
  def self.calculate_entropy(charset_size, length)
    (Math.log2(charset_size) * length).round(2)
  end

  # Assess password strength based on entropy value
  def self.password_strength(entropy)
    case entropy
    when 0..27   then "Very Weak"
    when 28..35  then "Weak"
    when 36..59  then "Reasonable"
    when 60..127 then "Strong"
    else              "Very Strong"
    end
  end

  def self.symbols
    %w[! " ' # $ % & ( ) * + , - . / : ; < = > ? ` ~ { | } @ ^]
  end

  def self.lowercase
    ('a'..'z').to_a
  end

  def self.uppercase
    ('A'..'Z').to_a
  end

  def self.numbers
    ('0'..'9').to_a
  end
end

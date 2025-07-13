require 'securerandom'

module Passw
  class InvalidConstraintsError < StandardError; end

  # Generate a password with specified options
  # Params:
  # +length+:: the length of the password
  # +options+:: a hash defining the attributes for the password
  # Returns a hash with :password and :entropy keys
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

    # Validate inputs
    validate_inputs(length, settings)

    # Enforce minimum length
    length = [length.to_i, settings[:min_length]].max

    # Build character set based on options
    character_set = build_character_set(settings)
    return '' if character_set.empty?

    # Filter out excluded characters
    character_set -= settings[:exclude]

    # Generate the password with necessary character types enforced
    password = generate_password(character_set, length, settings)

    # Calculate password entropy
    entropy = calculate_entropy(character_set.size, length)

    # Return both password and entropy
    {
      password: password.join,
      entropy: entropy,
      strength: password_strength(entropy)
    }
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
    max_attempts = length * 100  # Prevent infinite loops
    attempts = 0

    # Ensure at least one character from each type if enforce_types is enabled
    if settings[:enforce_types]
      required_chars = []
      required_chars << secure_sample(lowercase) if settings[:lowercase]
      required_chars << secure_sample(uppercase) if settings[:uppercase]
      required_chars << secure_sample(symbols) if settings[:symbols]
      required_chars << secure_sample(numbers) if settings[:numbers]
      
      # Shuffle required characters to avoid predictable positions
      required_chars = secure_shuffle(required_chars)
      password.concat(required_chars)
    end

    # Fill the rest of the password
    while password.length < length && attempts < max_attempts
      attempts += 1
      candidate = secure_sample(character_set)

      # Check constraints before adding
      next if !settings[:duplicates] && password.include?(candidate)
      next if settings[:avoid_sequences] && creates_sequence?(password, candidate)

      password << candidate
    end

    # Final shuffle while preserving enforce_types if needed
    if settings[:enforce_types]
      # Keep required chars, shuffle the rest
      required_count = count_required_types(settings)
      required_part = password[0...required_count]
      remaining_part = password[required_count..-1] || []
      password = required_part + secure_shuffle(remaining_part)
    else
      password = secure_shuffle(password)
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

  # Input validation
  def self.validate_inputs(length, settings)
    raise ArgumentError, "Length must be positive" if length.to_i <= 0
    
    # Check if any character types are enabled
    enabled_types = [:lowercase, :uppercase, :symbols, :numbers].count { |type| settings[type] }
    raise InvalidConstraintsError, "At least one character type must be enabled" if enabled_types == 0
    
    # Check if constraints are satisfiable
    if settings[:enforce_types]
      min_required = enabled_types
      if length.to_i < min_required
        raise InvalidConstraintsError, "Length (#{length}) must be at least #{min_required} when enforce_types is true"
      end
    end
    
    # Check if no-duplicates constraint is satisfiable
    if !settings[:duplicates]
      total_chars = 0
      total_chars += lowercase.size if settings[:lowercase]
      total_chars += uppercase.size if settings[:uppercase]
      total_chars += symbols.size if settings[:symbols]
      total_chars += numbers.size if settings[:numbers]
      total_chars -= settings[:exclude].size
      
      if length.to_i > total_chars
        raise InvalidConstraintsError, "Cannot generate #{length} unique characters from #{total_chars} available characters"
      end
    end
  end

  # Secure random sampling
  def self.secure_sample(array)
    array[SecureRandom.random_number(array.size)]
  end

  # Secure shuffling
  def self.secure_shuffle(array)
    # Fisher-Yates shuffle with SecureRandom
    result = array.dup
    (result.size - 1).downto(1) do |i|
      j = SecureRandom.random_number(i + 1)
      result[i], result[j] = result[j], result[i]
    end
    result
  end

  # Check if adding a character would create a sequence
  def self.creates_sequence?(password, candidate)
    return false if password.empty?
    
    last_char = password.last
    return true if (candidate.ord - last_char.ord).abs == 1
    
    # Check for repeating characters
    return true if candidate == last_char
    
    false
  end

  # Count required character types
  def self.count_required_types(settings)
    count = 0
    count += 1 if settings[:lowercase]
    count += 1 if settings[:uppercase]
    count += 1 if settings[:symbols]
    count += 1 if settings[:numbers]
    count
  end
end

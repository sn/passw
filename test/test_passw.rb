require 'minitest/autorun'
require_relative '../lib/passw'

class PasswTest < Minitest::Test
  def test_generate_with_default_options
    result = Passw.generate(12)
    assert_equal 12, result[:password].length
    assert result[:entropy] > 0
    assert_includes ['Very Weak', 'Weak', 'Reasonable', 'Strong', 'Very Strong'], result[:strength]
  end

  def test_generate_with_minimum_length
    result = Passw.generate(6, min_length: 10)
    assert_operator result[:password].length, :>=, 10
  end

  def test_generate_enforcing_character_types
    result = Passw.generate(12, {
      lowercase: true,
      uppercase: true,
      symbols: true,
      numbers: true,
      enforce_types: true
    })
    password = result[:password]

    assert_match(/[a-z]/, password, "Password should contain lowercase letters")
    assert_match(/[A-Z]/, password, "Password should contain uppercase letters")
    assert_match(/[!\"'\#\$%\&\(\)\*\+,\-\.\/:;<=>\?`~\{\|\}@\^]/, password, "Password should contain symbols")
    assert_match(/\d/, password, "Password should contain numbers")
  end

  def test_generate_with_exclude_characters
    result = Passw.generate(12, exclude: ['O', '0', 'I', 'l'])
    password = result[:password]
    refute_includes password.chars, 'O', "Password should not contain 'O'"
    refute_includes password.chars, '0', "Password should not contain '0'"
    refute_includes password.chars, 'I', "Password should not contain 'I'"
    refute_includes password.chars, 'l', "Password should not contain 'l'"
  end

  def test_generate_without_duplicates
    result = Passw.generate(12, duplicates: false)
    password = result[:password]
    assert_equal password.length, password.chars.uniq.length, "Password should have no duplicate characters"
  end

  def test_generate_avoiding_sequences
    result = Passw.generate(12, avoid_sequences: true)
    password = result[:password]
    assert_no_sequences(password)
  end

  def test_entropy_calculation
    character_set_size = 62 # Lowercase + Uppercase + Numbers
    length = 12
    entropy = Passw.send(:calculate_entropy, character_set_size, length)
    assert_in_delta 72, entropy, 5, "Entropy should be approximately 72 bits for a strong password"
  end

  def test_entropy_strength_assessment
    assert_equal "Very Weak", Passw.send(:password_strength, 25)
    assert_equal "Weak", Passw.send(:password_strength, 32)
    assert_equal "Reasonable", Passw.send(:password_strength, 45)
    assert_equal "Strong", Passw.send(:password_strength, 70)
    assert_equal "Very Strong", Passw.send(:password_strength, 130)
  end

  def test_input_validation
    assert_raises(ArgumentError) { Passw.generate(0) }
    assert_raises(ArgumentError) { Passw.generate(-5) }
    assert_raises(Passw::InvalidConstraintsError) {
      Passw.generate(12, lowercase: false, uppercase: false, symbols: false, numbers: false)
    }
  end

  def test_impossible_constraints
    assert_raises(Passw::InvalidConstraintsError) {
      Passw.generate(2, enforce_types: true, lowercase: true, uppercase: true, symbols: true, numbers: true)
    }
    assert_raises(Passw::InvalidConstraintsError) {
      Passw.generate(100, duplicates: false, lowercase: true, uppercase: false, symbols: false, numbers: false)
    }
  end

  def test_return_format
    result = Passw.generate(12)
    assert result.is_a?(Hash)
    assert result.key?(:password)
    assert result.key?(:entropy)
    assert result.key?(:strength)
    assert result[:password].is_a?(String)
    assert result[:entropy].is_a?(Float)
    assert result[:strength].is_a?(String)
  end

  private

  # Helper method to ensure there are no sequential characters
  def assert_no_sequences(password)
    password.chars.each_cons(2) do |a, b|
      refute_equal a.ord, b.ord - 1, "Password contains sequential characters: #{a}#{b}"
      refute_equal a.ord, b.ord + 1, "Password contains sequential characters: #{a}#{b}"
      refute_equal a, b, "Password contains repeating characters: #{a}#{b}"
    end
  end
end

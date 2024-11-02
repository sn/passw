require 'minitest/autorun'
require_relative '../lib/passw'

class PasswTest < Minitest::Test
  def test_generate_with_default_options
    password = Passw.generate(12)
    assert_equal 12, password.length
  end

  def test_generate_with_minimum_length
    password = Passw.generate(6, min_length: 10)
    assert_operator password.length, :>=, 10
  end

  def test_generate_enforcing_character_types
    password = Passw.generate(12, {
      lowercase: true,
      uppercase: true,
      symbols: true,
      numbers: true,
      enforce_types: true
    })

    assert_match(/[a-z]/, password, "Password should contain lowercase letters")
    assert_match(/[A-Z]/, password, "Password should contain uppercase letters")
    assert_match(/[!\"'\#\$%\&\(\)\*\+,\-\.\/:;<=>\?`~\{\|\}@\^]/, password, "Password should contain symbols")
    assert_match(/\d/, password, "Password should contain numbers")
  end

  def test_generate_with_exclude_characters
    password = Passw.generate(12, exclude: ['O', '0', 'I', 'l'])
    refute_includes password.chars, 'O', "Password should not contain 'O'"
    refute_includes password.chars, '0', "Password should not contain '0'"
    refute_includes password.chars, 'I', "Password should not contain 'I'"
    refute_includes password.chars, 'l', "Password should not contain 'l'"
  end

  def test_generate_without_duplicates
    password = Passw.generate(12, duplicates: false)
    assert_equal password.length, password.chars.uniq.length, "Password should have no duplicate characters"
  end

  def test_generate_avoiding_sequences
    password = Passw.generate(12, avoid_sequences: true)
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

  private

  # Helper method to ensure there are no sequential characters
  def assert_no_sequences(password)
    password.chars.each_cons(2) do |a, b|
      refute_equal a.ord, b.ord - 1, "Password contains sequential characters"
      refute_equal a.ord, b.ord + 1, "Password contains sequential characters"
    end
  end
end

require 'minitest/autorun'
require './lib/passw'

class WobblyTest < Minitest::Test
  def test_generate
    assert Passw.generate(12) != nil
  end
end

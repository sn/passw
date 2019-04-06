require 'minitest/autorun'
require './lib/wobbly'

class WobblyTest < Minitest::Test
  def test_seconds
    assert_in_delta Wobbly.in('0s'), Time.now
  end

  def test_minutes
    assert_in_delta Wobbly.in('30m'), Time.now + (30*60)
  end

  def test_hours
    assert_in_delta Wobbly.in('3h'), Time.now + (3*60*60)
  end

  def test_days
    assert_in_delta Wobbly.in('1D'), Time.now + (1*24*60*60)
  end

  def test_weeks
    assert_in_delta Wobbly.in('2W'), Time.now + (2*7*24*60*60)
  end

  def test_months
    assert_in_delta Wobbly.in('1M'), Time.now + (1*4*7*24*60*60)
  end

  def test_years
    assert_in_delta Wobbly.in('3Y'), Time.now + (3*12*4*7*24*60*60)
  end
end

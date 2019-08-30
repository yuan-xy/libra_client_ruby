require "test_helper"

class LibraTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Libra::VERSION
  end

  def test_it_does_something_useful
  	arr = [47, 115, 101, 110, 116, 95, 101, 118, 101, 110, 116, 115, 95, 99, 111, 117, 110, 116, 47]
    assert_equal arr, "/sent_events_count/".chars.map{|x| x.ord} 
  end
end

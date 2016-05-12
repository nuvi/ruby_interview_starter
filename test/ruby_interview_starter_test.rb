require 'test_helper'

class RubyInterviewStarterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyInterviewStarter::VERSION
  end

  def test_it_does_something_useful
    assert false
    puts "TEST CODE: HR#{Random.rand(5000)}RH"
  end
end

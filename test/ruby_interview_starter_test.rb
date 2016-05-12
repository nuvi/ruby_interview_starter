require 'test_helper'

class RubyInterviewStarterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyInterviewStarter::VERSION
  end

  def test_it_does_something_useful
    assert true
    puts "TEST CODE: HR#{Random.rand(5000)}RH"
  end

  def test_extract_to_folder
    file_path = File.expand_path("../files/news.zip", __FILE__)
    dest_path = File.expand_path("../files/extract", __FILE__)
    FileUtils.rm_rf("#{dest_path}/.", secure: true)
    assert_equal 0, Dir.glob(File.join(dest_path, "*.xml")).length
    RubyInterviewStarter::ZipExtract.extract_to_folder(file_path, dest_path)
    assert_equal 5118, Dir.glob(File.join(dest_path, "*.xml")).length
  end
end

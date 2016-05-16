require 'test_helper'

class ExtractorTest < Minitest::Test

  def text_can_extract_news_xml
    assert false
    puts "TEST CODE: HR#{Random.rand(5000)}RH"
  end

  def can_unzip
  	puts "asdfdsfaasdf"
  	file_path = File.expand_path('files/news.zip', __FILE__)

  	unzip(file_path)
  	assert_equal(File.file.exists?(file_path), true )
  end
end

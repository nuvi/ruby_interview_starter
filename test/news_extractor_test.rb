require './test_helper.rb'
require 'zip'
require 'pry'
require 'mechanize'
require 'open-uri'
require 'net/http'

class NewsExtractorTest < Minitest::Test
  def text_can_extract_news_xml
    assert false
    puts "TEST CODE: HR#{Random.rand(5000)}RH"
  end
end

def news
  n = 0
  Zip::File.open('./files/news.zip') do |zip_file|
    zip_file.each do |entry|
      n +=1
      puts "Extracting #{entry.name}"
      entry.extract("./files/extract/extractions#{n}.txt")
      content = entry.get_input_stream.read
    end
  end
end

def download
  b = 0
  agent = Mechanize.new
  page = agent.get('http://bitly.com/nuvi-plz')

  page.links.each do |link|
    filer(link, b)
    b += 1
  end

  binding.pry
end


def filer(link, b)
curlhttp://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/
end


# news

download

puts 'done'

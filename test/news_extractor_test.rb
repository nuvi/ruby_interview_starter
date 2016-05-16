# require './test_helper.rb'
require 'zip'
require 'mechanize'
require 'open-uri'
require 'net/http'
require 'redis'
require 'redis-objects'

# class NewsExtractorTest < Minitest::Test
#   def text_can_extract_news_xml
#     assert false
#     puts "TEST CODE: HR#{Random.rand(5000)}RH"
#   end
# end

def news
  Zip::File.open('./files/news.zip') do |zip_file|
    zip_file.each do |entry|
      puts "Extracting #{entry.name}"
      entry.extract("./files/extract/#{entry.name}.txt")
      content = entry.get_input_stream.read
    end
  end
end


  def download  
    b = 0
    agent = Mechanize.new
    page = agent.get('http://bitly.com/nuvi-plz')

    page.links.each do |link|
      if (link.href.include?(".zip")) && (b < 1)
        filer(link)
        b += 1
      end
    end
  end


  def filer (link)
   `curl http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"#{link}" --output files/downloads/#{link}`
    extraction (link.href)
  end

  def extraction (filename)
    list_name = filename
    @files = Redis::List.new("#{list_name}")
    Zip::File.open("./test/files/downloads/#{filename}") do |zip_file|
      zip_file.each do |entry|
        puts entry
        entry.extract("./files/unzipped/#{entry}")
        file = content(entry)
        @files << file
      end
    end
  end

  def content (entry)
    f = File.open("./test/files/unzipped/#{entry}", "r")
    file = []
    f.each_line do |line|
      file << line
    end
    f.close
    return file  
  end

    puts "- - - - - - - - - - - - - - - - - - - -"
    puts "Hello, this program allows you to download all zip files from this website (http://bitly.com/nuvi-plz) extract the zip files and then push them into a redis list."
    puts "Would you like to continue? (y/n) "
    ans = gets.strip
  def opening
    if ans == 'y'
      puts "Downloading..."
      download
    elsif ans == 'n'
      puts "Ok, goodbye"
    else
      puts "Invalid input, please try again"
      opening
    end
  end
  opening
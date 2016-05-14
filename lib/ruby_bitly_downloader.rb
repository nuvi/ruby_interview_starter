# I know I know... everyone loves nokogiri and I do too, but why use it when you can use a standard library, so I decided why not not use nokogiri... so that is this.

require 'rubygems'
require 'net/http'
require 'uri'
require 'pry'
require 'pry-byebug'

class RubyBitlyDownloader
  # Class Constants
  PAGE_URL = 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'

  def main
    response = get_response(PAGE_URL)
    parsed_response = parse_response(response)
    cleaned_response = clean_up_response_array(parsed_response)
    file_name_array = create_array_of_file_names(cleaned_response)
    uri_array = create_array_of_uri_obj(file_name_array)
    name_hash = zip_and_hash(uri_array, file_name_array)
    downloaded_files = download_files(name_hash)
  end

  # Just good ole Net::HTTP, no curl, no perl, no wget, just Net::HTTP because why not know standard ruby libs?
  def get_response url
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri).body
  end

  # No nokogiri parsing needed when you can isolate individual strings...
  def parse_response arg
    @response_array = []
    arg.each_line do |line|
      @response_array << line
    end
    return @response_array
  end

  # ... and then clean them up for exactly what you want...
  def clean_up_response_array arg
    arg.keep_if do |str|
      str[0..9] == "<tr><td><a"
    end
  end

  # ... and then take it and play!
  def create_array_of_file_names arr
    arr.map do |x|
      x.split(/"([^"]+)"/)[1]
    end
  end

  # Why this? Well... because net/http likes uri objs.
  def create_array_of_uri_obj arr
    arr.drop(1)
    arr.map do |i|
      URI("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/" + i)
    end
  end

  # more prep here...
  def zip_and_hash file_name_array, uri_array
    @file_hash = file_name_array.zip(uri_array).drop(1).to_h
  end

  # "I could make it 5 lines sandi... but I'm a rebel for legibility".
  def download_files file_hash
    file_hash.each do |k, val|
      res = Net::HTTP.get(k)
      File.open(File.expand_path('../test/files/downloads/' + val, "lib"), 'w+') do |file|
        file.write(res)
      end
    end
  end

end


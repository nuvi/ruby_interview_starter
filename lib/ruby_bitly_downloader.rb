require 'net/http'

class RubyBitlyDownloader
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

  def get_response url
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri).body
  end

  def parse_response arg
    @response_array = []
    arg.each_line do |line|
      @response_array << line
    end
    return @response_array
  end

  def clean_up_response_array arg
    arg.keep_if do |str|
      str[0..9] == "<tr><td><a"
    end
  end

  def create_array_of_file_names arr
    arr.map do |x|
      x.split(/"([^"]+)"/)[1]
    end
  end

  def create_array_of_uri_obj arr
    arr.drop(1)
    arr.map do |i|
      URI("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/" + i)
    end
  end

  def zip_and_hash file_name_array, uri_array
    @file_hash = file_name_array.zip(uri_array).drop(1).to_h
  end

  def download_files file_hash
    file_hash.each do |k, val|
      res = Net::HTTP.get(k)
      File.open(File.expand_path('../test/files/downloads/' + val, "lib"), 'w+') do |file|
        file.write(res)
      end
    end
  end

end


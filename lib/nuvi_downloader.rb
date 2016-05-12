require 'open-uri'
require 'mechanize'

class NuviDownloader
  def initialize
    @mech = Mechanize.new
    @mech.pluggable_parser.default = Mechanize::Download
    @logger = Logger.new(STDERR)
  end

  def download_files(url, destination)
    Dir.mkdir "#{destination}"   unless File.exists?("#{destination}")

    final_url = nil
    foo = open(url) { |io| final_url = io.base_uri}

    page = @mech.get final_url

    page.links.each do |link|
      next if !link.text.include?(".zip")

      # I added some puts to show the process was actually doing something...
      puts "Processing #{final_url}/#{link} => #{destination}/#{link.text}"

      # TODO this line fails sporadically with a socket error.  I'm rescuing and reporting for now
      # TODO     but would consider a retry loop or something like that to get the file...
      begin
        file = @mech.get("#{final_url}/#{link}").save("#{destination}/#{link.text}")
      rescue => error
        @logger.error"******  ERROR downloading file: #{final_url}/#{link}   #{error.message}"
      end
      break
    end
  end
end

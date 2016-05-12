require 'open-uri'
require 'mechanize'


# The following code can be placed in a download_runner.rb file to test the class operation
#
# $LOAD_PATH << File.dirname(__FILE__)
#
# require 'nuvi_downloader'
#
# # test runner to help develop download zip files to dest dir
#
# destdir = 'test/files/downloads'
# url = 'http://bitly.com/nuvi-plz'
#
# NuviDownloader.download_files(url, destdir)
#


class NuviDownloader
  def self.download_files(url, destination)
    Dir.mkdir "#{destination}"   unless File.exists?("#{destination}")

    final_url = nil
    foo = open(url) { |io| final_url = io.base_uri}

    mech = Mechanize.new
    mech.pluggable_parser.default = Mechanize::Download
    page = mech.get final_url

    page.links.each do |link|
      next if !link.text.include?(".zip")

      puts "getting #{final_url}#{link}..."
      mech.get("#{final_url}/#{link}").save("#{destination}/#{link.text}")
    end
  end
end

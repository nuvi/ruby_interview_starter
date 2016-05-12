require 'mechanize'
require 'pry'

class Downloader
  def self.download(url, destination)
    agent = Mechanize.new
    site = agent.get(url)
    links = site.links
    links.each_with_index do |l, i|
      unless i <= 5
        link = l.click
        link.save("destination/#{l.text}")
      end
    end
    # binding.pry
  end
end


Downloader.download('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/', 'test/files/downloads')

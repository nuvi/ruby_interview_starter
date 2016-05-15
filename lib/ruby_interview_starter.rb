require "./lib/ruby_interview_starter/version"
require 'zip'
require 'mechanize'
require "redis"

module RubyInterviewStarter
  # Your code goes here...

  class GetThoseFiles
    def unzip(zipped_file, directory)
      Zip::File.open(zipped_file) do |zip_file|
        # iterations = 10
        zip_file.each do |entry|
          entry.extract("#{directory}/#{entry.name}")
          content = entry.get_input_stream.read
          # if iterations <= 1
          #   break
          # end
          # iterations -= 1
        end
      end
    end
  end

  class DownloadFiles
    def scrape
      agent = Mechanize.new
      agent.pluggable_parser.default = Mechanize::Download
      page = agent.get('http://bitly.com/nuvi-plz')
      # iterations = 4
      page.links.each do |link|
        next unless /\.zip$/ =~ link.text
        # download files to test/files/downloads (deleted them after I knew it was working so I didn't push them to GitHub)
        file_holder = agent.get("http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/#{link.href}")
        file_holder.save("test/files/downloads/#{link.text}")
        # if iterations <= 1
        #   break
        # end
        # iterations -= 1
      end
    end
  end

  class ReadFiles
    def queue
      # zips = 4
      dir = Dir.entries("test/files/downloads/")
      dir.each do |file|
        next unless /\.zip$/ =~ file
        Zip::File.open("test/files/downloads/#{file}") do |zip_file|
          redis = Redis.new(:host => "127.0.0.1", :port => 6379, :db => 8)
          # xml = 10
          zip_file.each do |entry|
            content = entry.get_input_stream.read
            redis.set("#{entry.name}", content)
            # if xml <= 1
            #   break
            # end
            # xml -= 1
          end
        end
        # if zips <= 1
        #   break
        # end
        # zips -= 1
      end
    end
  end
end


# zipped_files = RubyInterviewStarter::GetThoseFiles.new
# zipped_files.unzip('test/files/news.zip', 'test/files/extract')

url_files = RubyInterviewStarter::DownloadFiles.new
url_files.scrape

files = RubyInterviewStarter::ReadFiles.new
files.queue

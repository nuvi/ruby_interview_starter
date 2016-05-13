# require "ruby_interview_starter/version"

module DataManipulator
  require 'rubygems'
  require 'zip'
  require 'pry'
  require 'redis'
  require 'mechanize'

  class FileManager
    def self.download(url, destination)
      agent = Mechanize.new
      site = agent.get(url)
      links = site.links
      links.each_with_index do |l, i|
        if i >= 5
          if i%5 == 0
            puts 'still downloading'
          end
          # binding.pry
          puts 'starting get'
          link = agent.get("#{url}/#{l.href}")
          puts 'starting save'
          link.save("#{destination}/#{l.text}")
          puts 'save complete'
        end
      end
    end

    def self.unzip(file, destination)
      Zip::File.open(file, destination) do |zip_file|
        zip_file.each do |entry|
          entry.extract("#{destination}/#{entry.name}") {true}
        end
      end
    end

    def self.redis_loader(directory)
      dir = Dir.open(directory)
      redis = Redis.new(:host => "127.0.0.1", :port => 6379, :db => 12)
      i = 0
      dir.each do |file|
        extension = file.split('.').last
        if extension == 'xml'
          if i%1000 == 0
            puts 'pushing on to Redis queue'
          end
          text = File.read("#{directory}/#{file}")
          redis.set(file, text)
          i+= 1
        end
      end
    end
  end
end

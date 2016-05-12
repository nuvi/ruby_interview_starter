# require "ruby_interview_starter/version"

module RubyInterviewStarter
  require 'rubygems'
  require 'zip'
  require 'pry'
  require 'redis'
  require 'mechanize'

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
    end
  end

  class Converter

    def self.unzip(file, destination)
      Zip::File.open(file, destination) do |zip_file|
        zip_file.each do |entry|
          entry.extract("#{destination}/#{entry.name}")
        end
      end
    end

    def self.move_to_redis(directory)
      dir = Dir.open(directory)
      redis = Redis.new(:host => "127.0.0.1", :port => 6379, :db => 1)
      dir.each do |file|
        extension = file.split('.').last
        if extension == 'xml'
          text = File.read("#{directory}/#{file}")
          redis.set(file, text)
        end

      end
    end
  end
end
include RubyInterviewStarter
Converter.move_to_redis(ARGV[0])

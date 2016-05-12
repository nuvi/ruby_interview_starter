require 'zip'
require 'redis'
require 'crack/xml'

redis = Redis.new

module RubyInterviewStarter
  class ZipToRedis
    def initialize(redis_url="redis://127.0.0.1:6379/0")
      @redis = Redis.new(:url => redis_url)
    end

    def run
      extract_download_files!
      push_extracted_files_to_redis!
    end

    def extract_download_files!
      dest_path = File.expand_path("../../../test/files/extract/", __FILE__)
      download_files = Dir[File.expand_path("../../../test/files/downloads/*.zip", __FILE__)]
      download_files.each do |path_to_zip|
        ::RubyInterviewStarter::ZipExtract.extract_to_folder(path_to_zip, dest_path)
        puts "Extracted #{path_to_zip}"
      end
    end

    def push_extracted_files_to_redis!
      xml_files = Dir[File.expand_path("../../../test/files/extract/*.xml", __FILE__)]
      xml_files.each do |xml|
        file_name = xml.split('/').last
        json = Crack::XML.parse(File.read(xml))
        @redis.set(file_name, json)
        puts "Added #{file_name} to redis"
      end
    end
  end
end

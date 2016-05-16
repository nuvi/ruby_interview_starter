require 'zip'
require 'fileutils'
require 'redis'

class RubyBitlyUnzipper
  FILE_LIST = Dir.glob(__dir__ + '/test/files/downloads/*.zip')
  DESTINATION_FOLDER = File.expand_path('../test/files/unzipped_downloads/', "lib")
  UNZIPPED_LIST = Dir.glob(__dir__ + '/test/files/unzipped_downloads/*')
  
  redis = Redis.new

  def self.execute
    unzipped_files = unzip_files(FILE_LIST, DESTINATION_FOLDER)
    store_files = redis_store(UNZIPPED_LIST)
  end
  
  def unzip_files file_arr, destination
    file_arr.each do |i|
      Zip::File.open(i) do |zip_file|
        zip_file.each {|entry|
          puts "Extracting #{entry.name}"
          entry.extract(destination + "/" + entry.name)
          content = entry.get_input_stream.read
        }
      end
    end
  end

  def redis_store unzipped_arr
    unzipped_arr.each do |file|
      redis.set File.basename(file), File.read(file)
    end
  end

end

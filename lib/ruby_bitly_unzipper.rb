require 'zip'
require 'fileutils'
require 'redis'
require 'pry'
require 'pry-byebug'

class RubyBitlyUnzipper
  # FILE_LIST = Dir.glob(__dir__ + '/test/files/downloads/*.zip')
  DESTINATION_FOLDER = File.expand_path('../test/files/unzipped_downloads/', "lib")
  UNZIPPED_LIST = Dir.glob(__dir__ + '/test/files/unzipped_downloads/*')
  
  redis = Redis.new

  def main
    zipped_array = glob_zipped
    unzipped = unzip_files(zipped_array)
    unzipped_glob = glob_unzipped
    store_files = redis_store(glob_unzipped)
  end

  def glob_zipped
    directory = File.join( "test", "files", "downloads", "*.zip")
    file_list = Dir.glob(directory)
  end
  
  def unzip_files arr
    arr.each do |i|
      Zip::File.open(i) do |zip_file|
        zip_file.each {|entry|
          puts "Extracting #{entry.name}"
          entry.extract(DESTINATION_FOLDER + "/" + entry.name)
          content = entry.get_input_stream.read
        }
      end
    end
  end

  def glob_unzipped
    unzipped_directory = File.join( "test", "files", "unzipped_downloads", "*")
    unzipped_arr = Dir.glob(unzipped_directory)
  end

  def redis_store unzipped_arr
    unzipped_arr.each do |file|
      redis.set File.basename(file), File.read(file)
    end
  end

end

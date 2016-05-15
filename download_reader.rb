require_relative './file_extraction'
require 'redis'
class DownloadReader
  def initialize(downloaded_dir, new_dir)
    @downloaded_dir = downloaded_dir
    @new_dir = new_dir
    @redis = Redis.new
    @fly = Fly.new(@new_dir)
  end

  def unzip_all_files
    Dir.foreach(@downloaded_dir) do |pants| 
      next if pants == '.' || pants == '..' 
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Unzipping #{pants}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"    
      @fly.unzip("#{@downloaded_dir}/#{pants}") 
    end  
  end

  def save_to_redis
    Dir.foreach(@new_dir) do |zip_file|
      zip_file_contents = File.open("#{@new_dir}/#{zip_file}")
      @redis.set(zip_file, zip_file_contents)
      # puts @redis.get(zip_file)
    end  
  end  
end  



# download_reader.unzip_all_files
# download_reader.save_to_redis

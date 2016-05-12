require 'rubygems'
require 'zip'
require 'pry'

def grab_the_zips()
  Zip::File.open('test/files/news.zip') do |zip_file|
    # directory for unzipping
    temp_dir = "test/files/extract/"
    # create directory if it does not exist
    Dir.mkdir(temp_dir) unless File.exists?(temp_dir)
    # open zip file and read through all files
    zip_file.each do |entry|
      puts "Extracting #{entry.name}"
      #creates path using temp dir and the name of the file
      final_path = File.join(temp_dir, entry.name)
      #saves the file to the directory created earlier with original file name 
      entry.extract(final_path)
    end
  end
end

puts "HELLO WORLD CODE: HR#{Random.rand(5000)}RH"
grab_the_zips()

require 'rubygems'
require 'zip'
require 'pry'

def grab_the_zips()
  Zip::File.open('test/files/news.zip') do |zip_file|
    # Handle entries one by one
    temp_dir = "test/files/extract/"
    Dir.mkdir(temp_dir) unless File.exists?(temp_dir)
    zip_file.each do |entry|
    # Extract to file/directory/symlink
      puts "Extracting #{entry.name}"
      final_path = File.join(temp_dir, entry.name)
      entry.extract(final_path)
    end
  end
end

puts "HELLO WORLD CODE: HR#{Random.rand(5000)}RH"
grab_the_zips()

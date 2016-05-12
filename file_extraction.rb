require 'rubygems'
require 'zip'

folder = 'test/files/'
input_dir = 'test/files/extract'
zipfile_name = 'test/files/news.zip'

Zip::File.open(zipfile_name, Zip::File::CREATE) do |zip_file|

  # never used this before by the way. :)

  zip_file.each do |zip|
    puts "extracting #{zip} file"
    input_path = "#{input_dir}/#{zip}"
    zip.extract(input_path)
  end  
end  
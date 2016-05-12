require 'rubygems'
require 'zip'


class Fly
  def initialize(input_dir)
    @input_dir = input_dir
    make_directory
  end

  def make_directory
    Dir.mkdir(@input_dir) unless File.exists?(@input_dir)
  end  
  
  def unzip(zipfile)
    Zip::File.open(zipfile, Zip::File::CREATE) do |zip_file|
      zip_file.each do |zip|
        puts "extracting #{zip} file"
        input_path = "#{@input_dir}/#{zip}"
        zip.extract(input_path)
      end  
    end  
  end  
end

fly = Fly.new('test/files/extract')

fly.unzip('test/files/news.zip')
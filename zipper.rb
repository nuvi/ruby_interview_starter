require 'rubygems'
require 'zip'
require 'pry'



class Zipper
  def self.unzip(file, destination)
    Zip::File.open(file, destination) do |zip_file|
      zip_file.each do |entry|
        # binding.pry
        entry.extract("#{destination}/#{entry.name}")
      end
    end
  end

end

# binding.pry
Zipper.unzip(ARGV[0], ARGV[1])

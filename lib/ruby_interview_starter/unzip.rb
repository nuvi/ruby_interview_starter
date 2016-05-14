require 'rubygems'
require 'zip'
class UnzipFile    
    
    def initialize
        # sets location and destination
        @zip_location = "./test/files/downloads/"
        @unzip_dest = './test/files/extract/'
        
    end
        
    def run
        # for each file in the location extract
        Dir.glob(@zip_location + '*.zip').each do |files|
            # extracts each file from the zip folder
            Zip::File.open(@zip_location + files) do |zip_file|            
                zip_file.each do |entry|
                    puts "Extracting #{entry.name}"
                    entry.extract(@unzip_dest + entry.name)
                end

                puts "Completed!"
            end
        end
    end
end


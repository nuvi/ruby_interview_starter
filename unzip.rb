require 'rubygems'
require 'zip'
class UnzipFile
    
    #having problems with cloud9's file system so this is theoretically correct but I havn't been able to debug it
    
    
    
    def initialize
        # sets location and destination
        @zip_location = "test/files/downloads/"
        @unzip_dest = 'test/files/extract/'
        
    end
        
    def run
        # for each file in the location extract
        Dir.glob(@zip_location + '*.xml').each do |files|
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

ye_olde_unzip = UnzipFile.new
ye_olde_unzip.run
require 'zip'
class UnzipFile
    
    @zip_location
    @unzip_dest
    
    def init
        # sets location and destination
        @zip_location = 'ruby_interview_starter/test/files/new.zip'
        @unzip_dest = 'ruby_interview_starter/test/files/extract'
    end
        
    def run
        # for each file in the location extract
        Zip::File.open(@zip_location) do |zip_file|
            zip_file.each do |entry|
                puts "Extracting #{entry.name}"
                entry.extract(@unzip_dest)
                #read through an IS
                content = entry.get_input_stream.read
            end
            
            #extension .csv
            entry = zip_file.glob('*.csv').first
            puts entry.get_input_stream.read
        end
    
    end
end
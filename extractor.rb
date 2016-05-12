require 'rubygems'
require 'zip'

class Extractor
	
	def extract_data
		Zip::File.open('test/files/news.zip') do |zip_file|
		  # Handle entries one by one
			fileStream = File.open('test/files/extract_data', 'a')
			zip_file.each do |entry|
		   		#Show the user each file being extracted
		   		puts "Extracting #{entry.name}"
		   		#Write out from the entries to the stream
		   		fileStream.write(entry.get_input_stream.read)
		   		
			end
			#clean up the file stream
			fileStream.close
		end
	end
	def extract_to_folder
		directory_name = "test/files/extract"
		Dir.mkdir(directory_name) unless File.exists?(directory_name)
		
		Zip::File.open('test/files/news.zip') do |zip_file|
			zip_file.each do |entry|
		   		#Show the user each file being extracted
		   		puts "Extracting #{entry.name}"
		   		entry.extract(directory_name+"/#{entry.name}")
		   	
		   	end
		end
	end
end

extractor = Extractor.new
extractor.extract_data
extractor.extract_to_folder
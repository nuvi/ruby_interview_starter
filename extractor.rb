require 'rubygems'
require 'zip'
require 'open-uri'

#Extracts data from a .zip to a directory or appends it to a file
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
		directory_name = 'test/files/extract'
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

#Downloads zip files from a URL to /test/files/downloads
class Zip_Downloader

	def download_zips
		#create a directory for the zip files if it doesnt exist
		directory_name = 'test/files/downloads'
		Dir.mkdir(directory_name) unless File.exists?(directory_name)
		
		#Open the url check if is a redirect
		open('http://bitly.com/nuvi-plz') {|f|
			string = f.base_uri.to_s
			reroute_url = string.match /http:\/\/.*\/.*\//
			
			#Iterate through the html line by line grab the filename to download
			f.each_line do |line|
				#find the filename in the line
				fileName = line.match /\d{13}.zip/
				#if it's not nil download it
				if (fileName != nil)
					then
						puts "Downloading #{fileName[0]}"
						File.open(directory_name+"/#{fileName[0]}", "w") do |file|
						file.write open(reroute_url[0] + "/#{fileName[0]}").read
					end
				end
			end
		}

	end
end

#extractor = Extractor.new
#extractor.extract_data
#extractor.extract_to_folder
grab_zips = Zip_Downloader.new
grab_zips.download_zips
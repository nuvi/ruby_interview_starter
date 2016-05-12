require 'rubygems'
require 'zip'
require 'open-uri'
require 'redis'

#Extracts data from a .zip to a directory or appends it to a file
class Extractor
	
	def extract_data
		Zip::File.open('test/files/news.zip') do |zip_file|
		  # Handle entries one by one
			file_stream = File.open('test/files/extract_data', 'a')
			zip_file.each do |entry|
		   		#Show the user each file being extracted
		   		puts "Extracting #{entry.name}"
		   		#Write out from the entries to the stream
		   		file_stream.write(entry.get_input_stream.read)
		   		
			end
			#clean up the file stream
			file_stream.close
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
				file_name = line.match /\d{13}.zip/
				#if it's not nil download it
				if (file_name != nil)
					then
						puts "Downloading #{file_name[0]}"
						File.open(directory_name+"/#{file_name[0]}", "w") do |file|
						file.write open(reroute_url[0] + "/#{file_name[0]}").read
					end
				end
			end
		}

	end
end
#Takes all .zip files in the test/files/downloads unzips them and pushes each XML file to a redis que
class Extract_And_Push

	def extract_data_and_push
		#keep track of how many XML files get pushed to the que
		num_entries = 0
		redis = Redis.new
		#switch directories
		Dir.chdir "test/files/downloads"
		#iterate through every zip file found in downloads
		Dir.glob("*.zip") do |file_name|
			#iterate through every XML file within the zip and push it to a redis que
			Zip::File.open(file_name) do |zip_file|
				zip_file.each do |entry|
					redis.rpush "nuvi", entry.get_input_stream.read
					num_entries +=1	
				end
			end
			
		end
		puts "#{num_entries} XML files added to que"
	end

end

#extractor = Extractor.new
#extractor.extract_data
#extractor.extract_to_folder
#grab_zips = Zip_Downloader.new
#grab_zips.download_zips
#send_to_redis = Extract_And_Push.new
#send_to_redis.extract_data_and_push
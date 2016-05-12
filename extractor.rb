require 'rubygems'
require 'zip'

class Extractor
	Zip::File.open('test/files/news.zip') do |zip_file|
	  # Handle entries one by one
		zip_file.each do |entry|
	   	
	   		puts "Extracting #{entry.name}"
	    	entry.extract('test/files/extract')
		end
	end
end

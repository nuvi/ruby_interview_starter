require 'rubygems'
require 'zip'
# require 'pry' #uncomment to debug

module Extractor
	class Zip
		class << self
			attr_accessor :counter
		end
		self.counter = 0

		def self.unzip(file_path, options: {})
			extract_path = options.fetch( :extract_path, File.dirname(file_path) + "/extract/" ) 

			Zip::File.open(file_path) do |zip_file|

		    zip_file.each do |file|
	        unless File.exist?(extract_path + file.name)
			      puts "extracting #{file.name} to #{@extract_path}"
			      self.counter += 1

	        	f_path = File.join(extract_path, file.name)
			      FileUtils::mkdir_p(File.dirname(f_path))
			      zip_file.extract(file, f_path) 
			    end
			  end
		    puts "extracted #{self.counter} files"

		  end

		end


	end
end

# file_path = File.expand_path('../../test/files/news.zip', __FILE__)

# Extractor::Zip.unzip( file_path ) #supply abs file path and an optional {extract_path:}. default xtract path is test/files/extract

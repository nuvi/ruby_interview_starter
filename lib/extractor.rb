require 'rubygems'
require 'zip'
# require 'pry' #uncomment to debug

module Extractor
	class ZipExtract
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
	        	dir = File.dirname(f_path)
			      FileUtils::mkdir_p( dir ) unless Dir.exists?( dir )
			      zip_file.extract(file, f_path) 
			    end
			  end
		    puts "extracted #{self.counter} files"

		  end

		end

	end
end
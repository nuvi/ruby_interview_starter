require 'zip'

module NewsExtractorTest
	class ExtractZip

		def unzip(file_path)
			Zip::ZipFile.open(file_path) { |zip_file|
		    zip_file.extract(f, "/test/files/extract") unless File.exist?("/test/files/extract")
		  }
		end


	end
end
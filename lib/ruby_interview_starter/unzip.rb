require '../../zip'

class UnzipFile
	@zip_location
	@unzip_dest

	def initialize
		@zip_location = './test/files/new.zip'
		@unzip_dest = './test/files/extract'
	end
end
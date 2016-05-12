$LOAD_PATH << File.dirname(__FILE__)

require 'nuvi_unzip'

NuviUnZip.unzip_file("test/files/news.zip")

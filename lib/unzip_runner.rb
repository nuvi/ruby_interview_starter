$LOAD_PATH << File.dirname(__FILE__)

require 'nuvi_unzip'

puts 'hello zipper'

NuviUnZip.unzip_file("test/files/news.zip", "test/files/extract")

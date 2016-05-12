$LOAD_PATH << File.dirname(__FILE__)

require 'nuvi_downloader'

# test runner to help develop download zip files to dest dir

destdir = 'test/files/downloads'
url = 'http://bitly.com/nuvi-plz'

NuviDownloader.download_files(url, destdir)

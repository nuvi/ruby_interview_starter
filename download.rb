require 'net/http/persistent'
require 'open_uri_redirections'

class DownloadFromBitly
    
    
    def init
        
        @dest_folder = "ruby_interview_starter/test/files/download"
    end
    


end

d = DownloadFromBitly.new
print d.download('http://bitly.com/nuvi-plz')
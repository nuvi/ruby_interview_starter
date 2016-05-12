require 'net/http/persistent'
require 'open_uri_redirections'

class DownloadFromBitly
    
    @dest_folder
    def init
        
        @dest_folder = "ruby_interview_starter/test/files/download"
    end
    
    def fetch(uri_str, limit = 10)
        url = URI.parse(uri_str)
  
        

        req = Net::HTTP::Get.new(url.path, {})
        response = Net::HTTP.start(url.host, url.port) { |http| http.request(req)}

        case response
        when Net::HTTPSuccess then url
        		
        when Net::HTTPRedirection then fetch(response['location'], limit -1)
        else response.error!
        end   
    end

    def download(uri_str)
    	url = fetch(uri_str)
    	http = Net::HTTP.post_form(url, {})
    end
end

d = DownloadFromBitly.new
print d.download('http://bitly.com/nuvi-plz')
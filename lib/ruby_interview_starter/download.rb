require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'

class DownloadFromBitly
    
    def initialize
    	@url = 'http://bitly.com/nuvi-plz' 
    	@url2 = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"       
        @dest_folder = "./test/files/downloads/"
        @zip_links = []
    end

    def compile_list_of_urls
    	data = Nokogiri::HTML(open(@url))
    	links = data.css("a[href]")
    	links.drop(5).each do |link|
    		@zip_links << link.attributes["href"].value
    	end
    end

    def download
    	compile_list_of_urls
    	@zip_links.each do |link|
    		uri = URI.parse(@url2 + link)
    		http_object = Net::HTTP.new(uri.host, uri.port)
    		http_object.start do |http|
    			request = Net::HTTP::Get.new uri.request_uri
    			http.read_timeout = 500
    			http.request request do |response|
    				open @dest_folder + link, 'w' do |io|
    					response.read_body do |chunk|
    						io.write chunk
    					end
    				end
    			end
	    		# rescue Exception => e
	    		# 	puts "=> Exception: '#{e}'. Skipping download."
	    		# 	return
	    		# end
	    	end
    	   	puts "Stored download as " + link + "."
    	end
    end
    


end


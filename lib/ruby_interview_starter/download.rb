require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'

class DownloadFromBitly
    
    def initialize
        # Set the urls and destination folder
    	@url = 'http://bitly.com/nuvi-plz' 
    	@url2 = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"       
        @dest_folder = "./test/files/downloads/"

        # create an array of all the a[href] tags
        @zip_links = []

    end

    def compile_list_of_urls
        # copy the html of the desired page and search for all a[href] tags
    	data = Nokogiri::HTML(open(@url))
    	links = data.css("a[href]")

        # each a[href] value gets added to @zip_link for naming and downloading
    	links.drop(5).each do |link|
    		@zip_links << link.attributes["href"].value
    	end
    end

    def download
        # call to previous function
    	compile_list_of_urls

        # for each link make a request and copy the downloaded file into the destination folder
    	@zip_links.each do |link|
    		uri = URI.parse(@url2 + link)
    		http_object = Net::HTTP.new(uri.host, uri.port)
    		http_object.start do |http|
                # make the request
    			request = Net::HTTP::Get.new uri.request_uri
    			http.read_timeout = 500
    			http.request request do |response|
                    # write the file to the disk
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


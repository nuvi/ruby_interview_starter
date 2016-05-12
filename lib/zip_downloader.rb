module ZipDownloader
	require 'net/http'

	class Downloader
		URLS = [ "http://bitly.com/nuvi-plz" ] 

		def download(urls)
			# no time panic psuedocode: grab body response with httpparty or such; grab zip link urls, download
			# httpparty body response
			body_urls.each do |url|
				Net::HTTP.start(url) { |http|
				  # resp = http.get("latest.zip")
				  # open("a.zip", "wb") { |file| 
				    # file.write(resp.body)
				  }
				}
			end
		end

	end

end
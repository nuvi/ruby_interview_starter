require 'fileutils'
require 'net/http'
require 'pry'

module Downloader

	class Connection

		def initialize(endpoint)
			@endpoint = endpoint
			@uri = URI.parse(endpoint)
	    @http = Net::HTTP.new(@uri.host, @uri.port)
		end

		def get_resources(type: type)
			@http.start do |http|
				request = Net::HTTP::Get.new @uri
				response = http.request request
				@resources = response.body.scan(/href="(.+?).zip"/).flatten
			end

			@resources.map! do |r|
				@endpoint + r + "." + type.to_s
			end
		end

		def get(dir, thread_count: 100)
			Downloader::Connection.create_dir(dir)

			queue = Queue.new
			@resources.map { |url| queue << url }

			threads = thread_count.times.map do 
		    Thread.new do
	        while !queue.empty? && url = queue.pop
	          file_name = url.split('/')[-1]
          	uri = URI.parse(url)
						Downloader::Connection.download(file_name, uri)
	        end
		    end
			end
			threads.each(&:join)
		end

		def self.download(filename, uri)
			Net::HTTP.start(uri.host, uri.port) do |http|
	      # request = Net::HTTP::Get.new uri.request_uri
	      request = Net::HTTP::Get.new uri
	      http.read_timeout = 500
	      http.request request do |response|
	        open filename, 'w' do |io|
	        	io.write response.body
	          # response.read_body do |chunk|
	            # io.write chunk	
	          # end
	        end
	      end
	    end
		end

		def self.create_dir(dirname)
		  unless Dir.exists?(dirname)
		    FileUtils::mkdir_p(dirname)
		  end
		  Dir.chdir(dirname)
		end

	end



end

# url = "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"

# connection = Downloader::Connection.new(url)

# connection.get_resources(type: :zip)

# destination_path = File.expand_path("../../test/files/downloads", __FILE__)

# connection.get( destination_path )
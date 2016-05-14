require 'rubygems'
require 'redis'

class RedisEntry

	def initialize
		@redis = Redis.new
		@path = './test/files/extract/'
	end

	def push_to_redis
		# find all .xml files in /extract
		Dir.glob(@path + '*.xml') do |item|
			#read the file and push it to the queue on Redis
			content = File.read(item)
			@redis.lpush('xml_files', content)
		end

		puts "Files uploaded to Redis"
	end
end




require 'rubygems'
require 'redis'

class RedisEntry

	def initialize
		@redis = Redis.new
		@path = './test/files/extract/'
	end

	def push_to_redis
		Dir.glob(@path + '*.xml') do |item|
			content = File.read(item)
			@redis.lpush('xml_files', content)
		end
		puts @redis.lindex('xml_files', 0)
		puts @redis.lindex('xml files', 0)
	end
end




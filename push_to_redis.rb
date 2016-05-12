require 'redis'

class RedisEntry

	def initialize
		@redis = Redis.new
		@path = 'test/files/extract'
	end

	def push_to_redis
		Dir.glob(@path + '*.xml') do |item|
			
			@redis.lpush('xml_files', item)
			
		end
		puts @redis.get('xml_files')
		puts @redis.get('xml files')
	end
end

r = RedisEntry.new
r.push_to_redis
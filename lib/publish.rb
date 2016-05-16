require "redis"
require "json"
require 'nokogiri'

module Publish

	class RedisPush

		VERB_MAP = { 	list: "sadd",
									olist: "zadd"
															}

		def initialize(filepath)
			@redis = Redis.new
			@doc = File.open(filepath) { |f| Nokogiri::XML(f) }
		end

		def serialize_xml(xml: @doc)
			title = xml.css('discussion_title').inner_text
			body_text = xml.css('topic_text').inner_text
			url = xml.css('topic_url').inner_text
			raw = xml.to_s

			data = {url: url, title: title, body: body_text, raw: raw}.to_json
		end

		def persist(method, key, data)
			@redis.send( VERB_MAP.fetch(method), key , data )
		end

		def delete(method, key, data)
			@redis.srem( key , data )
		end

	end

end

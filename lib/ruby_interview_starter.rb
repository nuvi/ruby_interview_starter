require "ruby_interview_starter"

module RubyInterviewStarter
  # puts "Hello, this program allows you to download all zip files from this website (http://bitly.com/nuvi-plz) extract the zip files and then push them into a redis list."
  puts "Test"
  word = gets.strip
  `ruby ./test/news_extractor_test.rb`
end

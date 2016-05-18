require_relative "ruby_interview_starter/version"
require_relative "ruby_bitly_downloader"
require_relative "ruby_bitly_unzipper"

module RubyInterviewStarter

  def self.execute
    download_files = RubyBitlyDownloader.new.main
    unzip_and_store = RubyBitlyUnzipper.new.main
  end

end

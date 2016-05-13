require "./lib/ruby_interview_starter/version"
require 'zip'

module RubyInterviewStarter
  # Your code goes here...

  class GetThoseFiles
    def unzip(zipped_file, directory)
      Zip::File.open(zipped_file) do |zip_file|
        # iterations = 10
        zip_file.each do |entry|
          entry.extract("#{directory}/#{entry.name}")
          content = entry.get_input_stream.read
          # if iterations <= 1
          #   break
          # end
          # iterations -= 1
        end
      end
    end
  end
end


zipped_files = RubyInterviewStarter::GetThoseFiles.new
zipped_files.unzip('test/files/news.zip', 'test/files/extract')

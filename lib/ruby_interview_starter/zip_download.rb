require 'open-uri'

module RubyInterviewStarter
  class ZipDownload
    def self.download_zip_files_to_path(url, dest_path)
      uri = ::URI.parse(url)
      html = uri.read
      regex = /href\s*=\s*"([^"]*)"/
      file_names = html.scan(regex).flatten.uniq
      file_names.select { |file_name| file_name =~ /\.zip$/ }.each do |file_name|
        download_url = "#{url}#{file_name}"
        download = open(download_url)
        ::IO.copy_stream(download, File.join(dest_path, file_name))
      end
    end
  end
end

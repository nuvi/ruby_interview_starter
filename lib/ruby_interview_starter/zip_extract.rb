require 'zip'

module RubyInterviewStarter
  class ZipExtract
    def self.extract_to_folder(file_path, dest_path)
      Zip::File.open(file_path) do |zip_file|
        zip_file.each do |entry|
          dest_file = File.join(dest_path, entry.name)
          entry.extract(dest_file)
        end
      end

      true
    end
  end
end

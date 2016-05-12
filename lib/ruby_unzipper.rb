require 'zip'

class RubyUnzipper

  FILE = File.expand_path('../test/files/news.zip', 'lib')
  EXTRACT_FOLDER = File.expand_path('../test/files/extract/', 'lib')

  
  def unzip_file (file, destination)
    destination = EXTRACT_FOLDER
    file = FILE

    Zip::File.open(file) do |zip_file|
     zip_file.each { |f|
       f_path=File.join(destination, f.name)
       FileUtils.mkdir_p(File.dirname(f_path))
       zip_file.extract(f, f_path) unless File.exist?(f_path)
     }
   end
  end

end

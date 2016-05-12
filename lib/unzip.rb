require 'zip'

class UnZip 

  def unzip
    Zip::ZipFile.open("test/files/news.zip") { |zip_file|
       zip_file.each { |f|
       f_path=File.join("test/files/extract", f.name)
       FileUtils.mkdir_p(File.dirname(f_path))
       zip_file.extract(f, f_path) unless File.exist?(f_path)
     }
    }
  end

end
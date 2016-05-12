require 'zip'

class NuviUnZip
  Zip.on_exists_proc = true

  def self.unzip_file(fname, destdir)
    Dir.mkdir "#{destdir}"   unless File.exists?("#{destdir}")

    Zip::File.open(fname) do |zip_file|
      # Handle entries one by one
      zip_file.each do |entry|
        entry.extract("#{destdir}/#{entry.name}")
      end
    end
  end
end
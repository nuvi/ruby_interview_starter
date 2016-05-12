require 'zip'

class NuviUnZip
  Zip.on_exists_proc = true

  def self.unzip_file(fname)
    dirname = File.dirname(fname)

    dest_file = "#{dirname}/extract"

    Zip::File.open(fname) do |zip_file|
      # Handle entries one by one
      zip_file.each do |entry|
        # Extract to file/directory/symlink
        puts "Extracting #{entry.name}"
        entry.extract(dest_file)
      end

    end
  end
end
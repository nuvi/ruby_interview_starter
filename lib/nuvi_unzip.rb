require 'zip'

# The following code can be placed in a unzip_runner.rb file to test the class operation
#
# $LOAD_PATH << File.dirname(__FILE__)
#
# require 'nuvi_unzip'
#
# test runner to help develop unzip class
#


class NuviUnZip
  Zip.on_exists_proc = true

  def self.unzip_file(fname)
    dirname = File.dirname(fname)

    dest_file = "#{dirname}/extract"
    Dir.mkdir "#{dest_file}"   unless File.exists?("#{dest_file}")

    Zip::File.open(fname) do |zip_file|
      # Handle entries one by one
      zip_file.each do |entry|
        # Extract to file/directory/symlink
        puts "Extracting #{entry.name}"
        entry.extract("#{dest_file}/#{entry.name}")
      end

    end
  end
end
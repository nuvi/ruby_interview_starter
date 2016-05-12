$LOAD_PATH << File.dirname(__FILE__)

require 'nuvi_unzip'
require 'redis'

class NuviRedisPusher
  def self.process_job(src_dir, work_dir)
    redis = Redis.new

    # get files in src_dir and iterate
    Dir["#{src_dir}/*"].each do |file|
      # extract if zip to work_dir
      if file.include?('.zip')
        NuviUnZip.unzip_file("#{file}", work_dir)

        redis.pipelined do
          # iterate files in work_dir
          Dir["#{work_dir}/*"].each do |workfile|
            if workfile.include?('.xml')
              redis.set(workfile, File.read(workfile))
            end
          end
        end
        # cleanup before next extract file
        Dir.foreach(work_dir) {|f| fn = File.join(work_dir, f); File.delete(fn) if f != '.' && f != '..'}
      end
    end
  end
end

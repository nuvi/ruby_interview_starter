$LOAD_PATH << File.dirname(__FILE__)

require 'nuvi_unzip'
require 'redis'

class NuviRedisPusher
  def initialize
    @redis = Redis.new
    @unzipper = NuviUnZip.new
  end

  def process_job(src_dir, work_dir)
    # get files in src_dir and iterate
    Dir["#{src_dir}/*"].each do |file|
      unzip_zipfile(file, work_dir)
      process_files_into_redis(work_dir)
    end
    # cleanup before next extract file
    Dir.foreach(work_dir) {|f| fn = File.join(work_dir, f); File.delete(fn) if f != '.' && f != '..'}
    @redis.save
  end

  def unzip_zipfile(file, work_dir)
    # extract if zip to work_dir
    if file.include?('.zip')
      # puts to show processing is happening...
      puts "Unzipping source file: #{file}"
      @unzipper.unzip_file("#{file}", work_dir)
    end
  end

  def process_files_into_redis(work_dir)
    queue = NuviRedisQueue.new(@redis)

    @redis.pipelined do
      # iterate files in work_dir
      Dir["#{work_dir}/*"].each do |workfile|
        if workfile.include?('.xml')
          puts "     adding workfile #{workfile} to redis..."
          queue.push(File.read(workfile))
        end
      end
    end
    # cleanup before next extract file
    Dir.foreach(work_dir) {|f| fn = File.join(work_dir, f); File.delete(fn) if f != '.' && f != '..'}
  end
end

class NuviRedisQueue
  def initialize(redis)
    @redis = redis
    q_id = @redis.incr("queue_index")
    @queuename = "nuvi_queue:#{q_id}"
    puts "\n\n*****************\nQueue Name:  #{@queuename}\n*****************\n\n"
  end

  def push(value)
    push_element = @redis.lpush(@queuename, value)
  end

  def pop(value)
    popped_value = @redis.rpop(@queuename)
    popped_value
  end
end

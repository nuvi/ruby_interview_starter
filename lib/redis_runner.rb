$LOAD_PATH << File.dirname(__FILE__)

require 'nuvi_redis_pusher'

# test runner to help develop download zip files to dest dir

srcdir = 'test/files'
workdir = 'test/files/extract'

redis_pusher = NuviRedisPusher.new
redis_pusher.process_job(srcdir, workdir)

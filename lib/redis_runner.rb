$LOAD_PATH << File.dirname(__FILE__)

require 'nuvi_redis_pusher'

# test runner to help develop download zip files to dest dir

srcdir = 'test/files'
workdir = 'test/files/extract'

NuviRedisPusher.process_job(srcdir, workdir)

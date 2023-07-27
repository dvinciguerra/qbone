# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("lib", __dir__)

require "qbone"

Qbone.configure do |config|
  #   config.redis = Redis.new
  #   config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::DEBUG
end

class SampleWorker
  include Qbone::Worker

  qbone_options queue: "sample", retries: 3

  def perform(arg1, arg2)
    puts "Hello, world #{arg1} #{arg2}!"
  end
end

SampleWorker.perform_async("foo", "bar")

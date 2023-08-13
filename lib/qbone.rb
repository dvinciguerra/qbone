# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(__dir__)

require 'json'
require 'logger'
require 'redis'
require "securerandom"

require "qbone/version"
require "qbone/job"
require "qbone/configuration"

module Qbone
  class Error < StandardError; end

  class << self
    def config
      @config ||=
        Configuration.new(
          redis: Redis.new,
          logger: Logger.new($stdout)
        )
    end

    def logger
      config.logger
    end

    def connection
      config.redis
    end

    def configure(&block)
      block.call(config)
    end

    def enqueue(class_name, *args)
      job_id = SecureRandom.hex
      enqueued_at = Time.now

      logger.debug(
        job_id:,
        class_name:,
        args:,
        enqueued_at:,
        message: "Enqueuing #{class_name}"
      )

      connection.rpush(
        class_name.queue,
        {
          class_name:,
          args:,
          enqueued_at:,
        }.to_json
      )
    end
  end
end

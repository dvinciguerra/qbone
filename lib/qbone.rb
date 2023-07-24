# frozen_string_literal: true

require_relative "qbone/version"

require 'json'
require 'logger'
require 'redis'
require "securerandom"

module Qbone
  class Error < StandardError; end

  module Worker
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def perform_async(*args)
        Qbone.enqueue(self, *args)
      end

      def queue
        "#{self::QUEUE}_queue"
      end

      def retry
        Integer(self::RETRY || 0)
      end

      def dead_letter
        "#{self::QUEUE}_dead_queue"
      end
    end
  end

  Configuration =
    Struct.new(:redis, :logger, keyword_init: true)

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

      logger.debug({
        job_id:,
        class_name:,
        args:,
        enqueued_at:,
        message: "Enqueuing #{class_name}",
      })

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

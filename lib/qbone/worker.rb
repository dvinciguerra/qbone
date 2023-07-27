# frozen_string_literal: true

module Qbone
  # qbone worker class
  module Worker
    def self.included(base)
      base.extend ClassMethods
    end

    # mixin class methods
    module ClassMethods
      def qbone_options(options)
        @@_options = { queue: nil, retries: 0 }.update(**options)
      end

      def perform_async(*args)
        Qbone.enqueue(self, *args)
      end

      def queue
        "#{@@_options[:queue]}_queue"
      end

      def retries
        Integer(@@_options[:retries])
      end

      def dead_letter
        "#{@@_options[:queue]}_dead_queue"
      end
    end
  end
end

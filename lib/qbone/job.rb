# frozen_string_literal: true

module Qbone
  # = Qbone Job class
  #
  # The Job class provide a mixin with all basic behabiours needed to
  # turn a class into a Qbone Job
  #
  # Example:
  #   class SampleWorker
  #     include Qbone::Job
  #
  #     qbone_options queue: "sample", retries: 3
  #
  #     def perform(arg1, arg2)
  #       puts "Hello, world #{arg1} #{arg2}!"
  #     end
  #   end
  module Job
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

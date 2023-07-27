# frozen_string_literal: true

module Qbone
  Configuration =
    Struct.new(:redis, :logger, keyword_init: true)
end

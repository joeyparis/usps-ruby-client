# frozen_string_literal: true
require 'logger'

module Usps
  class Logger < ::Logger
    def self.default
      return @default if @default

      logger = new $stdout
      logger.level = Logger::WARN
      @default = logger
    end
  end
end

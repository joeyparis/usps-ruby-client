# frozen_string_literal: true
require 'usps/version'
require 'usps/logger'
require 'usps/config'

require 'active_support'
require 'active_support/core_ext'
require 'builder'
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'logger'

require_relative 'usps/api/errors/usps_error'
require_relative 'usps/api/errors/too_many_requests_error'
# require_relative 'usps/api/error'
# require_relative 'usps/api/errors'
require_relative 'usps/faraday/response/raise_error'
require_relative 'usps/faraday/connection'
require_relative 'usps/faraday/request'
# require_relative 'usps/api/mixins'
require_relative 'usps/api/xml'
require_relative 'usps/api/endpoints'
# require_relative 'usps/pagination/cursor'
require_relative 'usps/client'

# module Usps
#   class Error < StandardError; end
#   # Your code goes here...
# end

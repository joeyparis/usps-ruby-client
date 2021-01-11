# frozen_string_literal: true
module Usps
  module Config
    extend self

    ATTRIBUTES = %i[
      proxy
      user_agent
      ca_path
      ca_file
      logger
      endpoint
      user_id
      token
      timeout
      open_timeout
      default_page_size
      default_max_retries
    ].freeze

    attr_accessor(*Config::ATTRIBUTES)

    def reset
      self.endpoint = 'https://secure.shippingapis.com/'
      self.user_agent = "USPS Ruby Client/#{Usps::VERSION}"
      self.ca_path = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_DIR : nil
      self.ca_file = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_FILE : nil
      self.user_id = nil
      self.token = nil
      self.proxy = nil
      self.logger = nil
      self.timeout = nil
      self.open_timeout = nil
      self.default_page_size = 100
      self.default_max_retries = 100
    end
  end

  class << self
    def configure
      block_given? ? yield(Config) : Config
    end

    def config
      Config
    end
  end
end

Usps::Config.reset

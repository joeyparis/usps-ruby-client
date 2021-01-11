# frozen_string_literal: true
module Usps
  class Client
    include Faraday::Connection
    include Faraday::Request
    include Api::Endpoints

    attr_accessor(*Config::ATTRIBUTES)

    def initialize(options = {})
      Usps::Config::ATTRIBUTES.each do |key|
        send("#{key}=", options.fetch(key, Usps.config.send(key)))
      end
      @logger ||= Usps::Config.logger || Usps::Logger.default
      @token ||= Usps.config.token
      @user_id ||= Usps.config.user_id
    end

    def build_request(action, options)
      xml = Builder::XmlMarkup.new(indent: 2)
      # xml.instruct!(:xml, version: '1.0', encoding: 'utf-8')
      xml.tag!("#{Usps::Api::Endpoints::ACTIONS[action]}Request", USERID: user_id) do
        send("build_#{action}_request", xml, options)
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
end

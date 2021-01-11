# frozen_string_literal: true
require 'amazing_print'
module Usps
  module Faraday
    module Response
      class RaiseError < ::Faraday::Response::Middleware
        def on_complete(env)
          raise Usps::Api::Errors::TooManyRequestsError, env.response if env.status == 429
          return unless (body = env.body) && body['Error']

          raise Usps::Api::Errors::UspsError.new(body['Error'], env.response)
        end
      end
    end
  end
end

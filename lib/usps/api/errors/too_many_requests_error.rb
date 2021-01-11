# frozen_string_literal: true
module Usps
  module Api
    module Errors
      class TooManyRequestsError < ::Faraday::Error
        attr_reader :response

        def initialize(response)
          @response = response
        end

        def message
          "Retry after #{retry_after} seconds"
        end

        def retry_after
          response.headers['retry-after'].to_i
        end
      end
    end
  end
end

# frozen_string_literal: true
module Usps
  module Api
    module Errors
      class UspsError < ::Faraday::Error
        attr_reader :response

        def initialize(error, response = nil)
          super error['Description']
          @error_number = error['Number']
          @error_description = error['Description']
          @error_source = error['Source']
          @response = response
        end

        def error
          response.body.error
        end

        def errors
          response.body.errors
        end

        def response_metadata
          response.body.response_metadata
        end
      end
    end
  end
end

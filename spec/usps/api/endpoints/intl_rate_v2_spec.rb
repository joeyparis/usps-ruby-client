# frozen_string_literal: true

# This file was auto-generated by lib/tasks/api.rake

require 'spec_helper'

RSpec.describe Usps::Api::Endpoints::IntlRateV2 do
  let(:client) { Usps::Client.new }
  context 'intl_rate_v2' do
    it 'requires intl_rate_v2_request' do
      expect { client.intl_rate_v2 }.to raise_error ArgumentError, /Required arguments :intl_rate_v2_request missing/
    end
  end
end

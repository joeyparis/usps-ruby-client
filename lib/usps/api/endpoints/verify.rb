# frozen_string_literal: true

# This file was auto-generated by lib/tasks/api.rake

module Usps
	module Api
		module Endpoints
			module Verify
				# @param [Hash] options
				# @option options [required, Hash] address_validate_request API = AddressValidateRequest
				#  * *:revision* (required, String) — Integer value used to return of all available response fields. Set this value to 1 to return all currently documented response fields. Example: Revision>1</Revision>
				#  * *:address* (required, Hash) — Up to 5 address verifications can be included per transaction.
				#    * *:firm_name* (String) — Firm Name Example:<FirmName>XYZ Corp.</FirmName>
				#    * *:address1* (String) — Delivery Address in the destination address. May contain secondary unit designator, such as APT or SUITE, for Accountable mail.)
				#    * *:address2* (required, String) — Delivery Address in the destination address. Required for all mail and packages, however 11-digit Destination Delivery Point ZIP+4 Code can be provided as an alternative in the Detail 1 Record.
				#    * *:city* (String) — City name of the destination address.
				#    * *:state* (String) — Two-character state code of the destination address.
				#    * *:urbanization* (String) — Urbanization. For Puerto Rico addresses only.
				#    * *:zip5* (String) — Destination 5-digit ZIP Code. Numeric values (0-9) only. If International, all zeroes.
				#    * *:zip4* (String) — Destination ZIP+4 Numeric values (0-9) only. If International, all zeroes. Default to spaces if not available.
				def verify(options = {})
					throw ArgumentError.new('Required arguments :address_validate_request missing') if options[:address_validate_request].nil?
					throw ArgumentError.new('Required arguments :address_validate_request, :revision missing') if options[:address_validate_request][:revision].nil?
					throw ArgumentError.new('Required arguments :address_validate_request, :address missing') if options[:address_validate_request][:address].nil?
					throw ArgumentError.new('Required arguments :address_validate_request, :address, :address2 missing') if options[:address_validate_request][:address][:address2].nil?

					request = build_request(:verify, options)
					get('https://secure.shippingapis.com/ShippingAPI.dll', {
						API: 'Verify',
						XML: request,
					})
				end

				private

				def tag_unless_blank(xml, tag_name, data)
					xml.tag!(tag_name, data) unless data.blank? || data.nil?
				end

				def build_verify_request(xml, options = {})
					xml.tag!('Revision', options[:address_validate_request][:revision])
					xml.tag!('Address') do
						tag_unless_blank(xml, 'FirmName', options[:address_validate_request][:address][:firm_name])
						tag_unless_blank(xml, 'Address1', options[:address_validate_request][:address][:address1])
						xml.tag!('Address2', options[:address_validate_request][:address][:address2])
						tag_unless_blank(xml, 'City', options[:address_validate_request][:address][:city])
						tag_unless_blank(xml, 'State', options[:address_validate_request][:address][:state])
						tag_unless_blank(xml, 'Urbanization', options[:address_validate_request][:address][:urbanization])
						tag_unless_blank(xml, 'Zip5', options[:address_validate_request][:address][:zip5])
						tag_unless_blank(xml, 'Zip4', options[:address_validate_request][:address][:zip4])
					end 
					xml.target!
				end

			end
		end
	end
end

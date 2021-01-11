# frozen_string_literal: true

# This file was auto-generated by lib/tasks/api.rake

module Usps
	module Api
		module Endpoints
			module USPSReturnsLabel
				#
				# USPS Returns Label API
				#
				# The Web Tools USPS Returns Label API enables
				# customers to receive USPS Returns service labels which are processed using the
				# new automated returns process via Package Platform. USPS Returns service account holders will pay
				# postage and fees through an Enterprise Payment System (EPS) account so that
				# items can be returned by their customers (at no charge to their customers)
				# using merchant provided USPS Returns service labels. The API allows integrators
				# to request USPS Returns service labels for
				# items that can be mailed using First-Class Package Return Service, Priority Mail Return Service, and Ground Return Service. For
				# additional USPS Returns service details, reference: https://www.federalregister.gov/documents/2020/02/25/2020-03170/usps-returns-service.
				#
				# @option option [(Alias)] :USPSReturnsLabelRequest (Required)
				# - Used with API=USPSReturnsLabel
				#   @option option [String] :Option (Optional)
				#   - For future use.
				#   @option option [String] :Revision (Optional)
				#   - For future use. Used to indicate API version.
				#   @option option [(Group)] :ImageParameters (Required)
				#   - Group containing all request parameters pertaining to the Label Image generation.
				#     @option option [String] :ImageType (Required)
				#     - Label Image Type. For example: <ImageType>PDF</ImageType>
				#     @option option [Boolean] :SeparateReceiptPage (Optional)
				#     - Flag to request a Separate Receipt Image. Enter “true” if you want receipt returned on a separate page – this will return label in <LabelImage> tag and receipt in <ReceiptImage> tag. For example: <SeparateReceiptPage>true</SeparateReceiptPage> Note: If not specified, receipt will return on same page as returns label. Response will contain a single <LabelImage> tag containing label and receipt on the same page.
				#     @option option [String] :CustomerFirstName (Optional)
				#     - First Name of customer returning package. Printed on label and receipt. Either <CustomerFirstName> and <CustomerLastName> OR <CustomerFirm> required. Minimum of 1 character required. Note: <CustomerFirstName> and <CustomerLastName> values have a combined 32-character limit when printed on label. Combined values exceeding 32 characters will be truncated due to space limitations on the label. API request eligible to accept up to 50 characters.
				#     @option option [String] :CustomerLastName (Optional)
				#     - Last Name of customer returning package. Printed on label and receipt. Either <CustomerFirstName> and <CustomerLastName> OR <CustomerFirm> required. Minimum of 1 character required. Note: <CustomerFirstName> and <CustomerLastName> values have a combined 32-character limit when printed on label. Combined values exceeding 32 characters will be truncated due to space limitations on the label. API request eligible to accept up to 50 characters.
				#     @option option [String] :CustomerFirm (Optional)
				#     - Firm Name of customer returning package. Printed on label and receipt. Either <CustomerFirstName> and <CustomerLastName> OR <CustomerFirm> required. Minimum of 1 character required. Note: <CustomerFirm> has a 32-character limit when printed on label. Values exceeding 32 characters will be truncated due to space limitations on the label. API request eligible to accept up to 50 characters.
				#     @option option [String] :CustomerAddress1 (Optional)
				#     - Secondary address unit designator and number (such as an apartment or suite number). For example: “APT 202” or “STE 100” etc. Note: This tag must be included in the request, even if the value is null, to return a successful response. For addresses that do not require secondary information, integrators should include “<CustomerAddress1/>” in the request.
				#     @option option [String] :CustomerAddress2 (Required)
				#     - Address of customer returning the package. (Primary Street address). For example: <CustomerAddress2>123 Main St.</CustomerAddress2>
				#     @option option [String] :CustomerCity (Required)
				#     - City of customer returning the package.
				#     @option option [String] :CustomerState (Required)
				#     - State of customer returning the package. Value should be passed as two-letter state abbreviation. For example: <CustomerState>DC</CustomerState>
				#     @option option [String] :CustomerZip5 (Required)
				#     - ZIP Code of customer returning the package.
				#     @option option [String] :CustomerZip4 (Optional)
				#     - ZIP+4 Code of customer returning the package.
				#     @option option [String] :POZipCode (Optional)
				#     - ZIP Code of Post Office or collection box where item is mailed. May be different than CustomerZip5. This tag will take precedence over CustomerZip5 when provided. For example: <POZipCode>20770</ POZipCode>
				#     @option option [Boolean] :AllowNonCleansedOriginAddr (Optional)
				#     - Allows Non-Validated Origin Street Address. Enter “true” to bypass street address validation failures/errors or “false” if only validated addresses should be allowed. Note: Integrators are recommended to always use “false” to ensure no delivery issues. In the event USPS cannot validate the street address, this tag will “bypass” address validation error when “true” is indicated to allow label creation which could impact delivery. The <AllowNonCleansedOriginAddr> excludes City, State, and ZIP Code which must be valid for a successful response. Reference https://pe.usps.com/text/pub28/28c2_001.htm.
				#     @option option [Integer] :WeightInOunces (Optional)
				#     - Package weight used to calculate postage. Items must weigh 70 pounds (1120 ounces) or less. For example: <WeightInOunces>80</ WeightInOunces> Note: If weight not supplied, 4oz used.
				#     @option option [String] :ServiceType (Required)
				#     - Enter one of the valid Mail Service entries: “PRIORITY” for Priority Mail Return Service. “FIRST CLASS” for First-Class Package Return Service. “GROUND” for Ground Return Service.
				#     @option option [Decimal] :Width (Optional)
				#     - Value must be numeric. Units are inches. For example: <Width>5.5</ Width> If partial dimensions are provided, an error response will return. Length, Width, Height are required for accurate pricing of a rectangular package when any dimension of the item exceeds 12 inches. In addition, Girth is required only for a non-rectangular package in addition to Length, Width, Height when any dimension of the package exceeds 12 inches. For rectangular packages, the Girth dimension must be left blank as this dimension is to only be used for non-rectangular packages. For details on dimensional weight pricing, please reference the Domestic Mail Manual Section 123.1.4 for Retail Mail and Section 223.1.6 for Commercial Mail. https://pe.usps.com/text/dmm300/index.htm
				#     @option option [Decimal] :Length (Optional)
				#     - Value must be numeric. Units are inches. Length should be longest dimension when compared to Width and Height values supplied. For example: <Length>11</Length> If partial dimensions are provided, an error response will return. Length, Width, Height are required for accurate pricing of a rectangular package when any dimension of the item exceeds 12 inches. In addition, Girth is required only for a non-rectangular package in addition to Length, Width, Height when any dimension of the package exceeds 12 inches. For rectangular packages, the Girth dimension must be left blank as this dimension is to only be used for non-rectangular packages. For details on dimensional weight pricing, please reference the Domestic Mail Manual Section 123.1.4 for Retail Mail and Section 223.1.6 for Commercial Mail. https://pe.usps.com/text/dmm300/index.htm
				#     @option option [Decimal] :Height (Optional)
				#     - Value must be numeric. Units are inches. For example: <Height>7</Height> If partial dimensions are provided, an error response will return. Length, Width, Height are required for accurate pricing of a rectangular package when any dimension of the item exceeds 12 inches. In addition, Girth is required only for a non-rectangular package in addition to Length, Width, Height when any dimension of the package exceeds 12 inches. For rectangular packages, the Girth dimension must be left blank as this dimension is to only be used for non-rectangular packages. For details on dimensional weight pricing, please reference the Domestic Mail Manual Section 123.1.4 for Retail Mail and Section 223.1.6 for Commercial Mail. https://pe.usps.com/text/dmm300/index.htm
				#     @option option [Decimal] :Girth (Optional)
				#     - Note: Girth is required only for a non-rectangular package. For rectangular packages, girth must be left blank. Value must be numeric. Units are inches. Girth is distance around the thickest part of package (perpendicular to the length). For details on dimensional weight pricing, please reference the Domestic Mail Manual Section 123.1.4 for Retail Mail and Section 223.1.6 for Commercial Mail https://pe.usps.com/text/dmm300/index.htm. For example: <Girth>25</Girth> Note: If partial dimensions are provided, an error response will return. (i.e. Length, Width, and Height must all be supplied with Girth).
				#     @option option [Boolean] :Machinable (Optional)
				#     - Indicates if packaging is Machinable. Used to calculate postage. For example: <Machinable>true</Machinable>
				#     @option option [String] :ShipDate (Optional)
				#     - Date Package Will Be Mailed. Ship date may be today plus 0 to 3 days in advance. Enter the date in either format: dd-mmm-yyyy, such as 14-Feb-2020, or mm/dd/ yyyy, such as 02/14/2020. If not provided, current day will be used as a basis for delivery date calculations. For example: <ShipDate>02/14/2011</ShipDate>
				#     @option option [String] :SenderName (Optional)
				#     - Used for the USPS Tracking email. Indicates the name of the person or company sending the USPS tracking email notification. Note: No email is returned when generating a Sample (i.e. API=USPSReturnsLabelCertify) request.
				#     @option option [String] :SenderEMail (Optional)
				#     - Used for the USPS Tracking email. Indicates the email address of sender used for USPS tracking email notification. Valid email addresses must be used. Note: <RecipientEMail> must be populated to generate USPS tracking email notification. If <SenderEMail> provided without <RecipientEMail>, USPS tracking email notification will not be generated. Note: No email is returned when generating a Sample (i.e. API=USPSReturnsLabelCertify) request.
				#     @option option [String] :RecipientName (Optional)
				#     - Used for the USPS Tracking email. Indicates the name of the person or company receiving the USPS tracking email notification. If recipient name not provided, email will be addressed to <RecipientEMail> value provided. Note: No email is returned when generating a Sample (i.e. API=USPSReturnsLabelCertify) request.
				#     @option option [String] :RecipientEMail (Optional)
				#     - Required to generate the USPS Tracking email. Indicates email address of recipient receiving the USPS tracking email notification. Valid email addresses must be used. Note: No email is returned when generating a Sample (i.e. API=USPSReturnsLabelCertify) request.
				#     @option option [(Group)] :ExtraServices (Optional)
				#     - Groups extra services elements
				#       @option option [Service Name] :ExtraService (Optional)
				#       - [{"Service Name"=>"Signature Confirmation Electronic", "Service ID"=>"156"}]

				#
				# @see 
				def usps_returns_label(options = {})
					throw ArgumentError.new('Required arguments :usps_returns_label_request missing') if options[:usps_returns_label_request].nil?
					throw ArgumentError.new('Required arguments :usps_returns_label_request, :image_parameters missing') if options[:usps_returns_label_request][:image_parameters].nil?
					throw ArgumentError.new('Required arguments :usps_returns_label_request, :image_parameters, :image_type missing') if options[:usps_returns_label_request][:image_parameters][:image_type].nil?
					throw ArgumentError.new('Required arguments :usps_returns_label_request, :image_parameters, :customer_address2 missing') if options[:usps_returns_label_request][:image_parameters][:customer_address2].nil?
					throw ArgumentError.new('Required arguments :usps_returns_label_request, :image_parameters, :customer_city missing') if options[:usps_returns_label_request][:image_parameters][:customer_city].nil?
					throw ArgumentError.new('Required arguments :usps_returns_label_request, :image_parameters, :customer_state missing') if options[:usps_returns_label_request][:image_parameters][:customer_state].nil?
					throw ArgumentError.new('Required arguments :usps_returns_label_request, :image_parameters, :customer_zip5 missing') if options[:usps_returns_label_request][:image_parameters][:customer_zip5].nil?
					throw ArgumentError.new('Required arguments :usps_returns_label_request, :image_parameters, :service_type missing') if options[:usps_returns_label_request][:image_parameters][:service_type].nil?

					request = build_request(:usps_returns_label, options)
					get('https://secure.shippingapis.com/ShippingAPI.dll', {
						API: 'USPSReturnsLabel',
						XML: request,
					})
				end

				private

				def tag_unless_blank(xml, tag_name, data)
					xml.tag!(tag_name, data) unless data.blank? || data.nil?
				end

				def build_usps_returns_label_request(xml, options = {})
					tag_unless_blank(xml, 'Option', options[:usps_returns_label_request][:option])
					tag_unless_blank(xml, 'Revision', options[:usps_returns_label_request][:revision])
					xml.tag!('ImageParameters') do
						xml.tag!('ImageType', options[:usps_returns_label_request][:image_parameters][:image_type])
						tag_unless_blank(xml, 'SeparateReceiptPage', options[:usps_returns_label_request][:image_parameters][:separate_receipt_page])
						tag_unless_blank(xml, 'CustomerFirstName', options[:usps_returns_label_request][:image_parameters][:customer_first_name])
						tag_unless_blank(xml, 'CustomerLastName', options[:usps_returns_label_request][:image_parameters][:customer_last_name])
						tag_unless_blank(xml, 'CustomerFirm', options[:usps_returns_label_request][:image_parameters][:customer_firm])
						tag_unless_blank(xml, 'CustomerAddress1', options[:usps_returns_label_request][:image_parameters][:customer_address1])
						xml.tag!('CustomerAddress2', options[:usps_returns_label_request][:image_parameters][:customer_address2])
						xml.tag!('CustomerCity', options[:usps_returns_label_request][:image_parameters][:customer_city])
						xml.tag!('CustomerState', options[:usps_returns_label_request][:image_parameters][:customer_state])
						xml.tag!('CustomerZip5', options[:usps_returns_label_request][:image_parameters][:customer_zip5])
						tag_unless_blank(xml, 'CustomerZip4', options[:usps_returns_label_request][:image_parameters][:customer_zip4])
						tag_unless_blank(xml, 'POZipCode', options[:usps_returns_label_request][:image_parameters][:po_zip_code])
						tag_unless_blank(xml, 'AllowNonCleansedOriginAddr', options[:usps_returns_label_request][:image_parameters][:allow_non_cleansed_origin_addr])
						tag_unless_blank(xml, 'WeightInOunces', options[:usps_returns_label_request][:image_parameters][:weight_in_ounces])
						xml.tag!('ServiceType', options[:usps_returns_label_request][:image_parameters][:service_type])
						tag_unless_blank(xml, 'Width', options[:usps_returns_label_request][:image_parameters][:width])
						tag_unless_blank(xml, 'Length', options[:usps_returns_label_request][:image_parameters][:length])
						tag_unless_blank(xml, 'Height', options[:usps_returns_label_request][:image_parameters][:height])
						tag_unless_blank(xml, 'Girth', options[:usps_returns_label_request][:image_parameters][:girth])
						tag_unless_blank(xml, 'Machinable', options[:usps_returns_label_request][:image_parameters][:machinable])
						tag_unless_blank(xml, 'ShipDate', options[:usps_returns_label_request][:image_parameters][:ship_date])
						tag_unless_blank(xml, 'SenderName', options[:usps_returns_label_request][:image_parameters][:sender_name])
						tag_unless_blank(xml, 'SenderEMail', options[:usps_returns_label_request][:image_parameters][:sender_e_mail])
						tag_unless_blank(xml, 'RecipientName', options[:usps_returns_label_request][:image_parameters][:recipient_name])
						tag_unless_blank(xml, 'RecipientEMail', options[:usps_returns_label_request][:image_parameters][:recipient_e_mail])
						xml.tag!('ExtraServices') do
							tag_unless_blank(xml, 'ExtraService', options[:usps_returns_label_request][:image_parameters][:extra_services][:extra_service])
						end if options[:usps_returns_label_request][:image_parameters][:extra_services].present?
					end 
					xml.target!
				end

			end
		end
	end
end
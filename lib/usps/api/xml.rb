module Usps
  module Api
    def tag_unless_blank(xml, tag_name, data)
      xml.tag!(tag_name, data) unless data.blank? || data.nil?
    end
  end
end

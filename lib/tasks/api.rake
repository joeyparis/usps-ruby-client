# frozen_string_literal: true
require 'amazing_print'
require 'nokogiri'
require 'erubis'
require 'active_support'
require 'active_support/core_ext'
require 'pry'
require 'helpers/erubis_helper'

namespace :usps do
  namespace :api do
    task :update do
      def dig_set(obj, keys, value)
        key = keys.first
        if keys.length == 1
          obj[key] = value
        else
          obj[key] = {} unless obj[key]
          dig_set(obj[key], keys.slice(1..-1), value)
        end
      end

      def table_array_to_hash_array(columns, rows)
        rows.map do |row|
          row_data = {}
          columns.each_with_index do |k, i|
            if row[i].is_a? String
              row_data[k.to_s.gsub(/[[:space:]]+/, ' ').strip] =
                row[i].to_s.gsub(/[[:space:]]+/, ' ').strip
            else
              row_data[k.to_s.gsub(/[[:space:]]+/, ' ').strip] = row[i]
            end
          end
          row_data
        end
      end

      def standardize_table_hash_array(arr)
        arr.map do |option|
          next if option['Tag Name'].split('/').pop.strip.casecmp('userid').zero?

          {
            type: option['Type'],
            name: option['Tag Name'].split('/').pop.strip,
            required: option['Occurs'] == 'Required',
            description: option['Description']
          }
        end.compact
      end

      def table_hash_array_to_shape(arr)
        shape = {}

        nesting = []
        arr[0][:type] = '(Alias)' unless arr[0][:type].casecmp('(alias)').zero?
        arr.each do |tag|
          if tag[:type].casecmp('(alias)').zero?
            if nesting.last == tag[:name]
              nesting.pop
            else
              nesting.push(tag[:name])
              dig_set(shape, nesting, tag.merge(children: {}))
            end
          elsif tag[:type].casecmp('(group)').zero?
            if nesting.last == tag[:name]
              nesting.pop(2)
            else
              nesting.push(:children)
              nesting.push(tag[:name])
              dig_set(shape, nesting, tag.merge(children: {}))
            end
          elsif nesting.length.positive?
            nesting_with_children = nesting + [:children]
            dig_set(shape, nesting_with_children,
                    shape.dig(*nesting_with_children).merge({ tag[:name] => tag.merge(children: {}) }))
          else
            shape[tag[:name]] = tag
          end
        end
        shape
      end

      def pp_xml(xml = '')
        doc = Nokogiri.XML(xml) do |config|
          config.default_xml.noblanks
        end
        doc.to_xml(indent: 2)
      end

      @failed_methods = []

      @endpoint_files = []

      def parse_doc(path)
        doc = Nokogiri::HTML(File.open(path))

        table_of_contents = {}
        raw_table_of_contents = doc.search('sdt[docparttype="Table of Contents"] p a').map do |link|
          full_title = link.content.tr("\n", ' ')
          next if full_title.blank?

          full_version = full_title.match(/^[\d.]+/)[0]
          major, minor, tiny = full_version.split('.')

          title = full_title.match(/\s+[A-Za-z\s\t.:]*\s+/)[0].gsub(/[[:space:]]+/,
                                                                    ' ').strip.chomp('.')

          data = {
            # full_title: full_title,
            # link: link['href'],
            anchor: link['href'].split('#')[1],
            version: full_version,
            major: major,
            minor: minor,
            tiny: tiny,
            title: title
          }

          table_of_contents[major] ||= []
          table_of_contents[major] << data

          data
        end

        data = table_of_contents.map do |section_number, section|
          section_data = {}
          section.each do |subsection|
            header_node = doc.search("a[name=#{subsection[:anchor]}]")[0].parent
            if header_node.content.blank? && header_node.next_element
              header_node = header_node.next_element
            end

            if header_node.next_element && header_node.next_element.content.present?
              content_node = header_node.next_element
            elsif header_node.parent.next_element && header_node.parent.next_element.content.present?
              content_node = header_node.parent.next_element
            else
              content_node = header_node.parent.parent.next_element
            end
            next unless content_node # For section 1

            section_data[:link] = subsection[:link]

            if subsection[:version] == "#{section_number}.0"
              section_data[:title] = subsection[:title]
            elsif subsection[:title] == 'Overview'
              section_data[:description] = content_node.content.tr("\n", ' ')
            elsif subsection[:title] == 'API Signature'
              columns, *rows = content_node.search('tr').map do |tr|
                tr.search('td').map do |td|
                  td.content.gsub(/\n\s/, '').strip
                end
              end
              section_data[:signature] = table_array_to_hash_array(columns, rows)
              section_data[:url] =
                "#{section_data[:signature][0]['Scheme']}#{section_data[:signature][0]['Host']}#{section_data[:signature][0]['Path'].chomp('?')}"
              section_data[:group] =
                section_data[:signature][0]['API'].sub('API=', '').gsub(/[[:space:]]+/,
                                                                        ' ').strip
            # ap section_data[:signature]
            # ap section_data[:signature].map{|s| s[]}
            # elsif subsection[:title] == "Request Descriptions"
            # 	columns, *rows = content_node.search('tr').map{|tr| tr.search('td').map{|td| td.content.gsub(/\n\s/, '').strip}}
            # 	section_data[:request_descriptions] = table_hash_array_to_shape(standardize_table_hash_array(table_array_to_hash_array(columns, rows)))
            elsif subsection[:title] == 'Sample Request'
              title, xml = content_node.content.gsub(/[[:space:]]+/, ' ').strip.split('<', 2)
              xml = pp_xml("<#{xml}")
              section_data[:sample_request] = <<~XML
                #{title}
                #{xml}
              XML
            elsif subsection[:title] == 'Response Descriptions' || subsection[:title] == 'Request Descriptions'
              columns, *rows = content_node.search('tr').map do |tr|
                next if tr.ancestors('table').length > 1

                tr.search('td').map do |td|
                  has_table = td.search('table').length.positive?
                  if !has_table
                    td.content.gsub(/\n\s/, '').strip
                  else
                    table = td.search('table')[0]
                    c, *r = table.search('tr').map do |tr|
                      tr.search('td').map do |td|
                        td.content.gsub(/\n\s/, '').strip
                      end
                    end
                    table_array_to_hash_array(c, r)
                  end
                end
              end.compact
              binding.pry if rows.blank?
              section_data[subsection[:title].downcase.gsub(/\s+/, '_').to_sym] =
                table_hash_array_to_shape(standardize_table_hash_array(table_array_to_hash_array(
                                                                         columns, rows
                                                                       )))
            elsif subsection[:title] == 'Sample Response'
              title, xml = content_node.content.gsub(/[[:space:]]+/, ' ').strip.split('<', 2)
              xml = pp_xml("<#{xml}")
              section_data[:sample_response] = <<~XML
                #{title}
                #{xml}
              XML
            end
          end

          section_data
        end

        method_template = Erubis::Eruby.new(File.read('lib/usps/api/templates/method.erb'))
        method_spec_template = Erubis::Eruby.new(File.read('lib/usps/api/templates/method_spec.erb'))
        data.each do |api|
          next if api[:group].nil? || api[:group].empty?

          # begin
          rendered_method = method_template.result(group: api[:group], data: api)
          File.write("lib/usps/api/endpoints/#{api[:group].underscore}.rb", rendered_method)

          rendered_method_spec = method_spec_template.result(group: api[:group], data: api)
          File.write("spec/usps/api/endpoints/#{api[:group].underscore}_spec.rb",
                     rendered_method_spec)

          @endpoint_files << {
            file: api[:group].underscore,
            module: api[:group].camelize
          }
          # rescue => e
          # 	@failed_methods << {
          # 		file: path,
          # 		api: api[:group],
          # 	}
          # end
        end
      end

      failed_docs = []
      Dir.glob('lib/data/api/*.htm').each do |f|
        ap f
        # begin
        parse_doc(f)
        # rescue => e
        # 	failed_docs << f
        # end
      end

      endpoints_template = Erubis::Eruby.new(File.read('lib/usps/api/templates/endpoints.erb'))
      File.write(
        'lib/usps/api/endpoints.rb',
        endpoints_template.result(files: @endpoint_files.sort_by { |f| f[:file] })
      )
    end
  end
end

require 'webdrivers/chromedriver'
require 'watir'
require 'amazing_print'

namespace :usps do
	namespace :api do
		task :download do
			Dir.glob('lib/data/api/*.htm').each do |f|
				file_name = f.split('/').last
				puts "Downloading #{file_name}"
				browser = Watir::Browser.new :chrome, headless: true
				browser.goto "https://www.usps.com/business/web-tools-apis/#{file_name}"
				File.write(
					"lib/data/api_downloaded/#{file_name}",
					browser.html
				)
			end
		end
	end
end

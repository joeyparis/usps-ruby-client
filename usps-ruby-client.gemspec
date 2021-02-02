# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('lib', __dir__)
require_relative 'lib/usps/version'

Gem::Specification.new do |spec|
  spec.name          = 'usps-ruby-client'
  spec.version       = Usps::VERSION
  spec.authors       = ['Joey Paris']
  spec.email         = ['joey@leadjig.com']

  spec.summary       = 'An automatically generated USPS API Client'
  spec.description   = 'An automatically generated USPS API Client based on the official USPS User Guides'
  spec.homepage      = 'https://www.usps.com/business/web-tools-apis/documentation-updates.htm'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/joeyparis/usps-ruby-client"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 6.1'
  spec.add_dependency 'builder', '~> 3.2'
  spec.add_dependency 'faraday', '~> 1'
  spec.add_dependency 'faraday_middleware', '~> 1'
  spec.add_dependency 'multi_xml', '~> 0.6'
  spec.add_development_dependency 'amazing_print', '~> 1.2'
  spec.add_development_dependency 'erubis', '~> 2.7'
  spec.add_development_dependency 'nokogiri', '~> 1.10'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.7'
  spec.add_development_dependency 'rubocop-performance', '~> 1.9'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.1'
  spec.add_development_dependency 'simplecov', '~> 0.21'
  spec.add_development_dependency 'yard', '~> 0.9'
end

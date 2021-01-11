$LOAD_PATH.push File.expand_path('lib', __dir__)
require_relative 'lib/usps/version'

Gem::Specification.new do |spec|
  spec.name          = "usps"
  spec.version       = Usps::VERSION
  spec.authors       = ["Joey Paris"]
  spec.email         = ["joey@leadjig.com"]

  spec.summary       = "Automatically generated USPS API Client"
  spec.description   = "Automatically generated USPS API Client"
  spec.homepage      = "https://www.usps.com/business/web-tools-apis/documentation-updates.htm"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_dependency 'builder'
  spec.add_dependency 'faraday', '>= 0.9'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'multi_xml'
  spec.add_development_dependency 'erubis'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'amazing_print'
end

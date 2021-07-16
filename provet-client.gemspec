# frozen_string_literal: true

require_relative 'lib/provet/version'

Gem::Specification.new do |spec|
  spec.name          = 'provet-client'
  spec.version       = Provet::VERSION
  spec.authors       = ['EmCousin']
  spec.email         = ['emmanuel@hey.com']
  spec.summary       = 'A Provet Cloud client for ruby'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')
  spec.homepage = 'https://github.com/EmCousin/provet-client'

  spec.metadata['allowed_push_host'] = 'http://mygemserver.com'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/EmCousin/provet-client/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'
end

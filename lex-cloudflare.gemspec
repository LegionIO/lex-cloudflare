# frozen_string_literal: true

require_relative 'lib/legion/extensions/cloudflare/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cloudflare'
  spec.version       = Legion::Extensions::Cloudflare::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Cloudflare'
  spec.description   = 'Connects LegionIO to Cloudflare services'
  spec.homepage      = 'https://github.com/LegionIO/lex-cloudflare'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-cloudflare'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-cloudflare'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-cloudflare/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-cloudflare/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 2.0'
end

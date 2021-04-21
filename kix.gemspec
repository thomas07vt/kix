# frozen_string_literal: true

require_relative "lib/kix/version"

Gem::Specification.new do |spec|
  spec.name          = "kix"
  spec.version       = Kix::VERSION
  spec.authors = ["John Thomas"]
  spec.email = ["thomas07@vt.edu"]

  spec.summary = "A gem to serialize objects using a similar API to active_model_serializers"
  spec.homepage = "https://github.com/thomas07vt/kix"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thomas07vt/kix"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "simplecov"
end

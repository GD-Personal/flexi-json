# frozen_string_literal: true

require_relative "lib/flexi/json/version"

Gem::Specification.new do |spec|
  spec.name = "flexi-json"
  spec.version = Flexi::Json::VERSION
  spec.authors = ["Gerda Decio"]
  spec.email = ["contact@gerdadecio.com"]

  spec.summary = "A ruby gem designed for manipulating JSON data."
  spec.description = "A versatile Ruby gem designed for manipulating JSON data. With functionalities for searching, generating new JSON, and transforming existing structures."
  spec.homepage = "https://github.com/GD-Personal/flexi-json"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["bug_tracker_uri"] = "https://github.com/GD-Personal/flexi-json/issues"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/GD-Personal/flexi-json"
  spec.metadata["changelog_uri"] = "https://github.com/GD-Personal/flexi-json/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "bundle-audit", "~> 0.1.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard", "~> 1.3"
  spec.add_development_dependency "simplecov", "~> 0.22.0"
  spec.add_development_dependency "simplecov_json_formatter", "~> 0.1.4"
  spec.add_development_dependency "debug", "~> 1.9.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

# frozen_string_literal: true

require_relative "lib/qbone/version"

Gem::Specification.new do |spec|
  spec.name = "qbone"
  spec.version = Qbone::VERSION
  spec.authors = ["Daniel Vinciguerra"]
  spec.email = ["daniel.vinciguerra@bivee.com.br"]

  spec.summary = "Qbone is a simple queue processor based on Redis"
  spec.description = "Qbone is a simple queue processor based on Redis"
  spec.homepage = "https://github.com/dvinciguerra/qbone"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "redis"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end


lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "indirect/version"

Gem::Specification.new do |spec|
  spec.name          = "indirect"
  spec.version       = Indirect::VERSION
  spec.authors       = ["Andre Arko"]
  spec.email         = ["andre@arko.net"]

  spec.summary       = %q{A CLI business card}
  spec.homepage      = "https://github.com/indirect/indirect"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/indirect/indirect"
    spec.metadata["changelog_uri"] = "https://github.com/indirect/indirect/blob/master/CHANGELOG.md"
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "colorize", "~> 0.8"
end

require_relative 'lib/libauth/jwt/version'

Gem::Specification.new do |spec|
  spec.name          = "libauth-jwt"
  spec.version       = Libauth::Jwt::VERSION
  spec.authors       = ["yusuke binsaki"]
  spec.email         = ["binsaki@craftorch.jp"]

  spec.summary       = %q{json-jwt wrapper with azure ad}
  spec.description   = %q{json-jwt wrapper with azure ad}
  spec.homepage      = "https://github.com/kage-development/libauth-jwt"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "github.com ci"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json-jwt"
end

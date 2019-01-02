
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "normalize_line_endings/version"

Gem::Specification.new do |spec|
  spec.name          = "normalize_line_endings"
  spec.version       = NormalizeLineEndings::VERSION
  spec.authors       = ["Matt Briggs","Alistair McKinnell"]
  spec.email         = ["alistairm@nulogy.com"]

  spec.summary       = %q(Converts \r\n characters to \n for attributes on ActiveModel-like entities.)
  spec.description   = %q(Converts \r\n characters to \n for attributes on ActiveModel-like entities.)
  spec.homepage      = "https://github.com/nulogy/normalize_line_endings"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(/^spec/) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 5.0", "< 6.0"

  spec.add_development_dependency "activemodel", ">= 5.0", "< 6.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
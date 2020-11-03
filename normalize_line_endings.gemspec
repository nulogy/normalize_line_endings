lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "normalize_line_endings/version"

Gem::Specification.new do |spec|
  spec.name = "normalize_line_endings"
  spec.version = NormalizeLineEndings::VERSION
  spec.authors = ["Matt Briggs", "Alistair McKinnell"]
  spec.email = ["alistairm@nulogy.com"]

  spec.summary = %q(Converts \r\n characters to \n for attributes on ActiveModel-like entities.)
  spec.homepage = "https://github.com/nulogy/normalize_line_endings"
  spec.license = "MIT"

  spec.metadata = {
    "homepage_uri" => "https://github.com/nulogy/normalize_line_endings",
    "changelog_uri" => "https://github.com/nulogy/normalize_line_endings/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/nulogy/normalize_line_endings",
    "bug_tracker_uri" => "https://github.com/nulogy/normalize_line_endings/issues"
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(/^spec/) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.6"

  spec.add_dependency "activesupport", "~> 5.2.4.3", "< 6.1"

  spec.add_development_dependency "activemodel", "~> 5.2.4.3", "< 6.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "rubocop", "~> 0.93"
  spec.add_development_dependency "rubocop-performance", "~> 1.8"
  spec.add_development_dependency "rubocop-rspec", "~> 1.44"
end

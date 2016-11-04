# -*- encoding: utf-8 -*-
VERSION = "1.0"

Gem::Specification.new do |spec|
  spec.name          = "motion-macos-screenshots"
  spec.version       = VERSION
  spec.authors       = ["Martin Kolb"]
  spec.email         = ["admin@vt-learn.de"]
  spec.description   = %q{A gem for taking automated screenshots in macOS applications written in Rubymotion}
  spec.summary       = %q{This gem lets you take screenshots of your macOS app written in Rubymotion}
  spec.homepage      = "https://vt-learn.de"
  spec.license       = ""

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end

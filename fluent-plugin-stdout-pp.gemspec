# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-stdout-pp"
  spec.version       = "0.1.0"
  spec.authors       = ["Masahiro Sano"]
  spec.email         = ["sabottenda@gmail.com"]
  spec.description   = %q{A fluentd plugin to pretty print json with color to stdout}
  spec.summary       = %q{A fluentd plugin to pretty print json with color to stdout}
  spec.homepage      = "https://github.com/sabottenda/fluent-plugin-stdout-pp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "fluentd", ">= 0.12.0", "< 2"
  spec.add_dependency "coderay"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit", "> 3"
end

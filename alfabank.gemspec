lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alfabank/version'

Gem::Specification.new do |spec|
  spec.name = 'alfabank'
  spec.version = Alfabank::VERSION
  spec.authors = ['Timur Yanberdin', 'Dan Kim']
  spec.email = ['yanberdint@gmail.com']

  spec.summary = 'Unofficial alfabank payment gateway gem'
  spec.homepage = 'https://github.com/mendab1e/alfabank'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.4'

  spec.add_dependency 'httparty', '~> 0.16'
end

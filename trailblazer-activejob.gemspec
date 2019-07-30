# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trailblazer/active_job/version'

Gem::Specification.new do |spec|
  spec.name = 'trailblazer-activejob'
  spec.version = Trailblazer::ActiveJob::VERSION
  spec.authors = ['Steve Reinke']
  spec.email = ['reinke@webit.de']

  spec.summary = %q{trigger trailblazer operations async via activejob}
  spec.description = %q{trigger trailblazer operations async via activejob}

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{bin,lib}/**/*']
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_runtime_dependency 'activejob', '>= 5.2.0'
  spec.add_runtime_dependency 'trailblazer', '>= 2.0'
end

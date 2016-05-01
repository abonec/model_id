require "bundler/gem_tasks"
begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = '--require spec_helper'
  end

  task :default => :spec
rescue LoadError
  # no rspec available
end


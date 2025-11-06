# frozen_string_literal: true

begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    Cucumber::Rake::Task.new(:ok) do |t|
      t.fork = false
      t.profile = 'default'
    end

    desc 'Run Cucumber features'
    task run: :environment do
      sh 'cucumber features'
    end
  end

  desc 'Alias for cucumber:ok'
  task cucumber: 'cucumber:ok'
rescue LoadError
  desc 'cucumber rake task not available'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem'
  end
end


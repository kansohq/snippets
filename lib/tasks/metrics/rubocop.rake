# encoding: utf-8

namespace :metrics do
  begin
    require 'rubocop/rake_task'
    RuboCop::RakeTask.new(:rubocop)

  rescue LoadError
    task :rubocop do
      $stderr.puts 'In order to run rubocop, you must: gem install rubocop'
    end
  end
end

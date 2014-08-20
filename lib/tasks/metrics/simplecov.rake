# encoding: utf-8

namespace :metrics do
  desc 'Run specs with coverage generation'
  task :simplecov do
    ENV['SIMPLECOV'] = '1'
    Rake::Task[:spec].invoke
  end
end

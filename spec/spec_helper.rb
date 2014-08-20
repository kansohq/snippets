if ENV['SIMPLECOV']
  require 'simplecov'

  SimpleCov.start do
    command_name 'spec:unit'
    add_filter 'config'
    add_filter 'spec'
    add_filter 'tabs'
  end
end

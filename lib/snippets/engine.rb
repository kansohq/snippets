module Snippets
  class Engine < ::Rails::Engine
    isolate_namespace Snippets

    config.generators do |g|
      g.test_framework :rspec
      g.template_engine :haml
    end
  end
end

require 'snippets/engine'

module Snippets
  mattr_accessor :controller_prefix, :defaults_load_path, :layout

  self.defaults_load_path ||= 'config/locales/**/*.yml'
  self.layout             ||= 'application'

  module ApplicationHelper
    def method_missing(method, *args, &block)
      if (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) && main_app.respond_to?(method)
        main_app.send(method, *args)
      else
        super
      end
    end
  end
end

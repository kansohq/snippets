require 'snippets/engine'
require 'pry'

module Snippets
  mattr_accessor :defaults_load_path

  self.defaults_load_path ||= 'config/locales/**/*.yml'

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

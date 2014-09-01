ApplicationController.class_eval do
  helper Snippets::SnippetsHelper
end

class Snippets::ApplicationController < ApplicationController
  respond_to :html
  layout -> { Snippets.layout }
end

class Snippets::ApplicationController < ApplicationController
  respond_to :html
  layout -> { Snippets.layout }
end

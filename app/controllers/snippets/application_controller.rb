class Snippets::ApplicationController < ApplicationController
  respond_to :html
  layout -> { Snippets.layout }

  def self.parent_prefixes
    if prefix = Snippets.controller_prefix
      [prefix] + super
    else
      super
    end
  end
end

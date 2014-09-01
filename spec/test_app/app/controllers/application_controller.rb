class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @page_title = Rails.cache.fetch('page_title') do
      I18n.t('page_title')
    end
  end
end

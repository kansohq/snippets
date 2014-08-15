module Snippets
  class SnippetsController < ApplicationController
    before_action :set_snippet, only: [:edit, :update, :destroy]
    after_action :store_params, only: [:index]

    def index
      @snippets = Kaminari.paginate_array(
        Snippet.all_with_defaults
      ).page(params[:page])

      respond_with @snippets
    end

    def search
      @snippets = Kaminari.paginate_array(
        Snippet.search(search_params)
      ).page(params[:page])

      respond_with @snippets do |f|
        f.html { render :index }
      end
    end

    def new
      @snippet = Snippet.new(new_params)
      respond_with @snippet
    end

    def edit
      respond_with @snippet
    end

    def create
      @snippet = Snippet.new(snippet_params)

      if @snippet.save
        respond_with @snippet do |f|
          f.html do
            redirect_to snippets_path(redirect_params),
              notice: t('.successful')
          end
        end
      else
        respond_with @snippet, status: :unprocessable_entity do |f|
          f.html { render :new }
        end
      end
    end

    def update
      if @snippet.update(snippet_params)
        respond_with @snippet do |f|
          f.html do
            redirect_to snippets_path(redirect_params),
              notice: t('.successful')
          end
        end
      else
        respond_with @snippet, status: :unprocessable_entity do |f|
          f.html { render :edit }
        end
      end
    end

    def destroy
      @snippet.destroy
      redirect_to snippets_path(redirect_params),
        notice: t('.successful')
    end

    private

    def set_snippet
      @snippet = Snippet.find(params[:id])
    end

    def store_params
      session[:stored_params] = {
        page: params[:page]
      }
    end
    
    def redirect_params(params = {})
      params ||= {}
      (session[:stored_params] || {}).merge(params)
    end

    def allowed_params
      %i(key value)
    end

    def new_params
      params.permit(allowed_params)
    end

    def snippet_params
      params.require(:snippet).permit(allowed_params)
    end

    def search_params
      params.require(:q)
    end
  end
end

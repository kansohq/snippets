module Snippets
  class SnippetsController < ApplicationController
    before_action :set_snippet, only: [:edit, :update, :destroy]

    def index
      @snippets = Kaminari.paginate_array(
        Snippet.all_with_defaults
      ).page(params[:page])
    end

    def new
      @snippet = Snippet.new(new_params)
    end

    def edit
    end

    def create
      @snippet = Snippet.new(snippet_params)

      if @snippet.save
        redirect_to snippets_path, notice: t('.successful')
      else
        render :new
      end
    end

    def update
      if @snippet.update(snippet_params)
        redirect_to snippets_path, notice: t('.successful')
      else
        render :edit
      end
    end

    def destroy
      @snippet.destroy
      redirect_to snippets_path, notice: t('.successful')
    end

    private

    def set_snippet
      @snippet = Snippet.find(params[:id])
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
  end
end

module Snippets
  module SnippetsHelper
    def cache(*opts)
      @in_cache_call = opts
      super(*opts)
    end

    def t(*opts)
      if @in_cache_call.present?
        cache_key     = @in_cache_call.first
        translate_key = opts.first
        Snippet.view_cache_record_list(translate_key) << cache_key
      end

      super(*opts)
    end
  end
end

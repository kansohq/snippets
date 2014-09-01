module Snippets
  module SnippetsHelper
    def cache(*args)
      Snippets.in_cache_call = opts
      super(*args)
      Snippets.in_cache_call = false
    end

    def translate(*opts)
      if Snippets.in_cache_call.present?
        translate_key = opts.first
        Snippet.view_cache_record_list(translate_key) << cache_key
      end

      super(*opts)
    end

    def localize(*opts)
      if Snippets.in_cache_call.present?
        localize_key = (opts.last || {})[:format]
        if localize_key.present?
          Snippet.view_cache_record_list(localize_key) << cache_key
        end
      end

      super(*opts)
    end

    private

    def cache_key
      Snippets.in_cache_call.first if Snippets.in_cache_call.present?
    end
  end
end

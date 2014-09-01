module ActiveSupport
  module Cache
    class Store
      alias_method :original_fetch, :fetch

      def fetch(*args, &block)
        Snippets.in_cache_call = args
        result = original_fetch(*args, &block)
        Snippets.in_cache_call = false
        result
      end
    end
  end
end

module I18n
  class << self
    alias_method :original_translate, :translate
    alias_method :original_localize, :localize

    def translate(*args)
      if Snippets.in_cache_call.present?
        translate_key = args.first
        cache_key = Snippets.in_cache_call.first
        Snippets::Snippet.store_view_cache_record(translate_key, cache_key)
      end

      original_translate(*args)
    end

    alias_method :t, :translate

    def localize(*args)
      if Snippets.in_cache_call.present?
        localize_key = (opts.last || {})[:format]
        cache_key = Snippets.in_cache_call.first
        Snippets::Snippet.store_view_cache_record(localize, cache_key)
      end

      original_localize(*args)
    end

    alias_method :l, :localize
  end
end

module ActionView
  module Helpers
    module TranslationHelper
      alias_method :original_translate, :translate

      def translate(*args)
        if Snippets.in_cache_call.present?
          translate_key = args.first
          cache_key = Snippets.in_cache_call.first
          Snippets::Snippet.store_view_cache_record(translate_key, cache_key)
        end

        original_translate(*args)
      end

      alias_method :t, :translate
    end
  end
end

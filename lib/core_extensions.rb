module ActiveSupport
  module Cache
    class Store
      alias_method :original_fetch, :fetch

      def fetch(*args)
        Snippets.in_cache_call = args
        original_fetch(*args)
        Snippets.in_cache_call = false
      end
    end
  end
end

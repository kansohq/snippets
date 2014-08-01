module Snippets
  class SnippetDefaults < SimpleDelegator
    class << self
      def all
        @snippets ||= (
          snippets = default_snippets
          snippets = flatten_snippets(snippets)
          mapped_snippets(snippets)
        )
      end

      private

      def backend
        @backend ||= (
          backend = I18n::Backend::Simple.new
          backend.load_translations(
            Dir[Rails.root.join('config', 'locales', 'snippets', '**', '*.yml')]
          )
          backend
        )
      end

      def default_snippets
        backend.send(:translations)[I18n.default_locale]
      end

      def flatten_snippets(snippets)
        to_shallow_hash(snippets)
      end

      def mapped_snippets(snippets)
        snippets.map { |k, v| Snippet.new(key: k, value: v) }
      end

      # From https://github.com/mynewsdesk/translate
      def to_shallow_hash(hash)
        hash ||= {}

        hash.each_with_object({}) do |(key, value), shallow_hash|
          if value.is_a?(Hash)
            to_shallow_hash(value).each do |sub_key, sub_value|
              shallow_hash[[key, sub_key].join('.')] = sub_value
            end
          else
            shallow_hash[key.to_s] = value
          end
          shallow_hash
        end
      end
    end
  end
end

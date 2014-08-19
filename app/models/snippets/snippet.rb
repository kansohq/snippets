module Snippets
  class Snippet < ActiveRecord::Base
    validates :key, :value, presence: true
    validates :key, uniqueness: true

    before_save :cache
    before_destroy :clear_cache

    class << self
      def all_with_defaults
        (all + Snippets::SnippetDefaults.all).uniq(&:key).sort_by!(&:key)
      end

      def search(search)
        results = all_with_defaults

        Search.attributes.each do |attr|
          search_val = search.send(attr)

          if search_val.present?
            results = results.delete_if do |snippet|
              snippet_val = snippet.send(attr)
              snippet_val.nil? || (
                snippet_val.present? &&
                !snippet_val.downcase.scan(search_val.downcase).present?
              )
            end
          end
        end

        results
      end

      def cache_all
        all.map(&:cache)
      end
    end

    def cache
      store_value(key_was, nil) if key_changed?
      store_value(key, value)
    end

    def clear_cache
      store_value(key, nil)
    end

    private

    def store_value(key, value)
      I18n.backend.store_translations(
        I18n.default_locale,
        { key => value },
        escape: false
      )
    end
  end
end

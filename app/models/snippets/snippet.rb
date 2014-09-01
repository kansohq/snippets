module Snippets
  class Snippet < ActiveRecord::Base
    validates :key, :value, presence: true
    validates :key, uniqueness: true

    before_save :cache
    before_destroy :clear_cache
    after_save :clear_view_cache_records

    class << self
      def all_with_defaults
        (all + Snippets::SnippetDefaults.all).uniq(&:key).sort_by!(&:key)
      end

      def cache_all
        all.map(&:cache)
      end

      def view_cache_record_list(key)
        Redis::List.new(key)
      end

      def store_view_cache_record(key, value)
        unless view_cache_record_list(key).include?(value) || key.blank?
          view_cache_record_list(key) << value
        end
      end
    end

    def cache
      store_value(key_was, nil) if key_changed?
      store_value(key, value)
    end

    def clear_cache
      store_value(key, nil)
    end

    def view_cache_records
      Snippet.view_cache_record_list(key)
    end

    def clear_view_cache_records
      view_cache_records.each do |key|
        Rails.cache.delete(key)
      end
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

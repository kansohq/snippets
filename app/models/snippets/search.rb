module Snippets
  class Search
    extend ActiveModel::Naming
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion

    class << self
      def attributes
        @attributes
      end

      def search_attributes(attributes = [])
        @attributes = attributes
        send(:attr_accessor, *@attributes)
      end
    end

    search_attributes [:key, :value]

    def initialize(attributes = {})
      attributes ||= {}
      attributes.each do |k, v|
        send(:"#{k}=", v)
      end
    end

    def perform_search?
      self.class.attributes.any? { |a| send(a).present? }
    end

    def persisted?
      false
    end
  end
end

module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :fields

    private

    def search_by(*fields)
      @fields = fields
    end
  end

  included do
    def self.search(term)
      where(@fields.map { |field| "#{field} LIKE :term" }.join(' OR '), term: "%#{term}%")
    end
  end
end

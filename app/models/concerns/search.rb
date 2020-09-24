module Search
  extend ActiveSupport::Concern

  included do
    def self.search(fields, term)
      where(fields.map { |field| "#{field} LIKE :term" }.join(' OR '), term: "%#{term}%")
    end
  end
end

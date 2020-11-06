class Document < ApplicationRecord
  include Searchable
  search_by :title

  belongs_to :department

  enum category: { declaration: 'declaration', certification: 'certification' }, _suffix: :category

  validates :category, inclusion: { in: Document.categories.values }
  validates :title, :front_text, :back_text, :department_id, presence: true

  def self.human_categories
    hash = {}
    categories.each_key { |key| hash[I18n.t("enums.categories.#{key}")] = key }
    hash
  end
end

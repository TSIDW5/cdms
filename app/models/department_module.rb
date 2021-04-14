class DepartmentModule < ApplicationRecord
  belongs_to :department

  has_many :department_module_users, dependent: :destroy
  has_many :users, through: :department_module_users

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def search_non_members(term)
    User.where('unaccent(name) ILIKE unaccent(?)', "%#{term}%").order('name ASC').where.not(id: user_ids)
  end
end

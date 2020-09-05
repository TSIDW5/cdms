class DepartmentModule < ApplicationRecord
  belongs_to :department

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end

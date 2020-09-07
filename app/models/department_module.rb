class DepartmentModule < ApplicationRecord
  belongs_to :department
  has_many :module_users, dependent: :destroy
  has_many :users, through: :module_users

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def users
    ModuleUser.by_module(id).includes([:user])
  end

  def collaborators
    ModuleUser.collaborators_by_module(id)
  end
end

class Role < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :name, :identifier, presence: true
  validates :identifier, uniqueness: true
end

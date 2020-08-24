class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true
  validates :register_number, presence: true
  validates :cpf, presence: true
  validates :status, inclusion: [true, false]
end

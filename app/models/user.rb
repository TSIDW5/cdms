class User < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+\Z/ }
  validates :register_number, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :status, inclusion: [true, false]

  before_save do
    self.email = self.username + "@utfpr.edu.br"
  end
end

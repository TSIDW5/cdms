class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+\Z/ }
  validates :register_number, presence: true
  validates :cpf, presence: true
  validates :status, inclusion: [true, false]
  validate :validate_cpf

  before_save do
    self.email = self.username + '@utfpr.edu.br'
  end

  def validate_cpf
    errors.add(:cpf, I18n.t('flash.users.validations.cpf')) unless CPF.valid?(cpf)
  end
end

require 'cpf_cnpj'

class AudienceMember < ApplicationRecord
  validates :name, :cpf, :email, presence: true
  validates :cpf, :email, uniqueness: true
  validates :cpf, case_sensitive: false
  validates :name, length: { minimum: 2 }
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: :bad_email }
  validate  :validate_cpf

  def validate_cpf
    errors.add(:cpf, I18n.t('activerecord.errors.models.audience_member.attributes.cpf.bad_cpf')) unless CPF.valid?(cpf)
  end
end

class AudienceMember < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 2 }
  validates :cpf, :email, uniqueness: true, case_sensitive: false
  validates_email_format_of :email, message: I18n.t('errors.messages.invalid')
  validates_cpf_format_of :cpf, message: I18n.t('errors.messages.invalid')

  def self.my_import(file)
    valid_audiencemembers = []
    invalid_audiencemembers = []
    CSV.foreach(file, headers: true) do |row|
      audiencemember = AudienceMember.new(row.to_h)
      audiencemember.password = '123456'
      audiencemember.password_confirmation = '123456'
      if audiencemember.valid?
        valid_audiencemembers << audiencemember
      else
        invalid_audiencemembers << audiencemember
      end
    end
    [AudienceMember.import(valid_audiencemembers, returning: :name), invalid_audiencemembers]
  end
end

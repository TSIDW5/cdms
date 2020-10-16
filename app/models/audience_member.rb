class AudienceMember < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include Searchable
  search_by :name

  validates :name, presence: true, length: { minimum: 2 }
  validates :cpf, :email, uniqueness: true, case_sensitive: false
  validates_email_format_of :email, message: I18n.t('errors.messages.invalid')
  validates_cpf_format_of :cpf, message: I18n.t('errors.messages.invalid')

  def self.my_import(file)
    valid_audience_members = []
    invalid_audience_members = []
    CSV.foreach(file, headers: true) do |row|
      audience_member = format_audience_member(row.to_h)
      add_to_correct_array(audience_member, valid_audience_members, invalid_audience_members)
    end
    [AudienceMember.import(valid_audience_members, returning: :name), invalid_audience_members]
  end

  def self.format_audience_member(row)
    audience_member = AudienceMember.new(row)
    audience_member.password = '123456'
    audience_member.password_confirmation = '123456'
    audience_member
  end

  def self.add_to_correct_array(audience_member, valid_audience_members, invalid_audience_members)
    if audience_member.valid?
      valid_audience_members << audience_member
    else
      invalid_audience_members << audience_member
    end
  end
end

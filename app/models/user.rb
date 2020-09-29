class User < ApplicationRecord
  has_many :department_users, dependent: :destroy
  has_many :departments, through: :department_users

  belongs_to :role, optional: true

  validates :name, presence: true
  validates :register_number, presence: true
  validates :username, uniqueness: true, format: { with: /\A[a-z0-9]+\Z/ }
  validates_cpf_format_of :cpf, message: I18n.t('errors.messages.invalid')

  mount_uploader :avatar, AvatarUploader

  def username=(username)
    super(username)

    self.email = "#{username}@utfpr.edu.br"
  end

  def is?(role)
    return true if role.eql?(:admin) && self.role

    self.role&.identifier.eql?(role.to_s)
  end

  def self.admins
    includes(:role).where.not(role_id: nil)
  end

  def self.search_non_admins(term)
    where(role_id: nil).where('unaccent(name) ILIKE unaccent(?)', "%#{term}%").order('name ASC')
  end
end

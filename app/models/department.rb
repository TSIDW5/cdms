class Department < ApplicationRecord
  has_many :department_modules, dependent: :destroy
  has_many :department_users, dependent: :destroy
  has_many :users, through: :department_users

  validates :name, presence: true
  validates :initials, presence: true, uniqueness: true
  validates :local, presence: true
  validates_email_format_of :email, message: I18n.t('errors.messages.invalid')
  validates :email, uniqueness: true
  validates :phone, format: { with: /\A[1-9]{2}9[0-9]{8}\z|\A[1-9]{2}[0-9]{8}\z/ }

  def modules
    department_modules
  end

  def search_non_members(term)
    User.where('unaccent(name) ILIKE unaccent(?)', "%#{term}%").order('name ASC').where.not(id: user_ids)
  end
end

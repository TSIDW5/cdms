class Department < ApplicationRecord
  has_many :department_modules, dependent: :destroy

  validates :name, presence: true
  validates :initials, presence: true, uniqueness: true
  validates :local, presence: true
  validates_email_format_of :email, message: I18n.t('errors.messages.invalid')
  validates :email, uniqueness: true
  validates :phone, format: { with: /\A[1-9]{2}9[0-9]{8}\z|\A[1-9]{2}[0-9]{8}\z/ }

  def modules
    department_modules
  end
end

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :department_users, dependent: :destroy
  has_many :module_users, dependent: :destroy
  has_many :departments, through: :department_users
  has_many :department_modules, through: :module_users

  validates :name, presence: true
  validates :register_number, presence: true
  validates :username, uniqueness: true, format: { with: /\A[a-z0-9]+\Z/ }
  validates_cpf_format_of :cpf, message: I18n.t('errors.messages.invalid')

  scope :active, -> { where(active: true) }
  scope :filter_of_department_by_name, ->(keyword, department) { where('LOWER(name) LIKE ?', "%#{keyword.downcase}%").where.not(id: department.users.pluck(:user_id)) }
  scope :filter_of_module_by_name, ->(keyword, department_module) { where('LOWER(name) LIKE ?', "%#{keyword.downcase}%").where.not(id: department_module.users.pluck(:user_id)) }
  scope :sorted, -> { order(name: :asc) }

  def username=(username)
    super(username)

    self.email = "#{username}@utfpr.edu.br"
  end
end

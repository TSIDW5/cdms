class ModuleUser < ApplicationRecord
  belongs_to :user
  belongs_to :department_module

  delegate :name, :email, :active?, to: :user
  delegate :id, to: :user, prefix: :user

  enum role: { responsible: 0, collaborator: 1 }

  validates :user, :department_module, :role, presence: true
  validates :role, inclusion: { in: roles }
  validates :user, uniqueness: { scope: :department_module }
  validate :validate_duplicated_responsible, if: :responsible?

  scope :by_module, ->(department_module_id) { where(department_module_id: department_module_id) }
  scope :collaborators_by_module, ->(department_module_id) { by_module(department_module_id).where(role: roles[:collaborator]) }
  scope :responsible_by_module, ->(department_module_id) { by_module(department_module_id).where(role: roles[:responsible]) }
  scope :by_user_and_module, ->(user_id, department_module_id) { by_module(department_module_id).where(user_id: user_id) }

  def validate_duplicated_responsible
    already_has_responsible = ModuleUser.responsible_by_module(department_module.id).count != 0
    errors.add(:department_module, I18n.t('activerecord.models.department_module.duplicated_responsible')) if already_has_responsible
  end
end

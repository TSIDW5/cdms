class DepartmentUser < ApplicationRecord
  belongs_to :user
  belongs_to :department

  delegate :name, :email, :active?, to: :user
  delegate :id, to: :user, prefix: :user

  enum role: { responsible: 0, collaborator: 1 }

  validates :user, :department, :role, presence: true
  validates :role, inclusion: { in: roles }
  validates :user, uniqueness: { scope: :department }
  validate :validate_duplicated_responsible, if: :responsible?

  scope :by_department, ->(department_id) { where(department_id: department_id) }
  scope :collaborators_by_department, ->(department_id) { by_department(department_id).where(role: roles[:collaborator]) }
  scope :responsible_by_department, ->(department_id) { by_department(department_id).where(role: roles[:responsible]) }
  scope :by_user_and_department, ->(user_id, department_id) { by_department(department_id).where(user_id: user_id) }

  def validate_duplicated_responsible
    already_has_responsible = DepartmentUser.responsible_by_department(department.id).count != 0
    errors.add(:department, I18n.t('activerecord.models.department.duplicated_responsible')) if already_has_responsible
  end
end

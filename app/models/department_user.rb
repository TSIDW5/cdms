class DepartmentUser < ApplicationRecord
  belongs_to :department
  belongs_to :user

  enum role: { responsible: 'responsible', collaborator: 'collaborator' }, _suffix: :role

  validates :role, inclusion: { in: DepartmentUser.roles.values }
  validates :user, uniqueness: { scope: :department_id }
  validate :only_one_responsible, if: :responsible_role?

  def self.human_roles
    hash = {}
    roles.each_key { |key| hash[I18n.t("enums.roles.#{key}")] = key }
    hash
  end

  private

  def only_one_responsible
    return if department.department_users.responsible_role.count.zero?

    errors.add(:role, I18n.t('errors.messages.taken'))
  end
end

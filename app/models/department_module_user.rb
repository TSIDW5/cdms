class DepartmentModuleUser < ApplicationRecord
  belongs_to :department_module
  belongs_to :user

  enum role: { responsible: 'responsible', collaborator: 'collaborator' }, _suffix: :role

  validates :role, inclusion: { in: DepartmentModuleUser.roles.values }
  validates :user, uniqueness: { scope: :department_module_id }
  #validate :only_one_responsible, if: :responsible_role?

  def self.human_roles
    hash = {}
    roles.each_key { |key| hash[I18n.t("enums.roles.#{key}")] = key }
    hash
  end

  private

  def only_one_responsible
    return if department_module.department_module_users.responsible_role.count.zero?

    errors.add(:role, I18n.t('errors.messages.taken'))
  end
end

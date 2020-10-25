class DepartmentModuleUser < ApplicationRecord
  before_save :link_user_in_department

  belongs_to :department_module
  belongs_to :user

  enum role: { responsible: 'responsible', collaborator: 'collaborator' }, _suffix: :role

  validates :role, inclusion: { in: DepartmentModuleUser.roles.values }
  validates :user, uniqueness: { scope: :department_module_id }
  #validate :only_one_responsible, if: :responsible_role?  TO_DO HABILITAR UNICO RESPONSAVEL PELO MODULO

  def self.human_roles
    hash = {}
    roles.each_key { |key| hash[I18n.t("enums.roles.#{key}")] = key }
    hash
  end

  private

  def link_user_in_department
    if user_not_linked_department
      departmentUser = DepartmentUser.new(department_id: self.department_module.department_id, user_id: self.user.id, role: :collaborator )
      departmentUser.save
    end 
  end

  def user_not_linked_department
    return DepartmentUser.includes(:department, :user).where(users:{id: self.user.id}).where(departments: {id: self.department_module.department_id}).count.zero? 
  end

  def only_one_responsible
    return if department_module.department_module_users.responsible_role.count.zero?

    errors.add(:role, I18n.t('errors.messages.taken'))
  end
end

require_relative 'base_populate'

class Populators::DepartmentModuleUserPopulate < Populators::BasePopulate
  def self.populate(_amount = 30)
    instance.delete
    instance.create
    instance.log(DepartmentModuleUser.count)
  end

  def create
    DepartmentModule.pluck(:id).each do |department_module_id|
      user_ids = self.user_ids
      responsible_user_id = user_ids.pop
      add_department_module_member(DepartmentModuleUser.roles[:responsible], responsible_user_id, department_module_id)

      user_ids.each do |user_id|
        add_department_module_member(DepartmentModuleUser.roles[:collaborator], user_id, department_module_id)
      end
    end
  end

  def user_ids
    User.pluck(:id).sample(rand(1..5))
  end

  def add_department_module_member(role, user_id, department_module_id)
    DepartmentModuleUser.create!(
      role: role,
      user_id: user_id,
      department_module_id: department_module_id
    )
  end
end

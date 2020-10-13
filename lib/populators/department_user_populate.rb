require_relative 'base_populate'

class Populators::DepartmentUserPopulate < Populators::BasePopulate
  def self.populate(_amount = 30)
    instance.delete
    instance.create
    instance.log(DepartmentUser.count)
  end

  def create
    Department.pluck(:id).each do |department_id|
      user_ids = self.user_ids
      responsible_user_id = user_ids.pop
      add_department_member(DepartmentUser.roles[:responsible], responsible_user_id, department_id)

      user_ids.each do |user_id|
        add_department_member(DepartmentUser.roles[:collaborator], user_id, department_id)
      end
    end
  end

  def user_ids
    User.pluck(:id).sample(rand(1..5))
  end

  def add_department_member(role, user_id, department_id)
    DepartmentUser.create!(
      role: role,
      user_id: user_id,
      department_id: department_id
    )
  end
end

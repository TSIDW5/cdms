module Populaters
  class DepartmentUserPopulate
    def self.insert
      Department.all.each do |department|
        amount_of_users = rand(1..5)
        users = User.all.limit(amount_of_users)
        users.each_with_index do |user, index|
          user_role = index.zero? ? DepartmentUser.roles[:responsible] : DepartmentUser.roles[:collaborator]

          DepartmentUser.create!(
            role: user_role,
            user: user,
            department: department
          )

          puts "Inserted user '#{user.name}' on department '#{department.name}'"
        end
      end
    end
  end
end

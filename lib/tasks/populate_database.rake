require_all 'lib/populaters'

namespace :db do
  desc 'Erase and fill database'
  task populate: :environment do
    include Populaters

    puts 'Deleting data'
    [DepartmentUser, User, Role, AudienceMember, DepartmentModule, Department].each(&:delete_all)

    puts 'Running seeds'
    Rake::Task['db:seed'].invoke

    puts 'Inserting users'
    UserPopulate.insert(30)

    puts 'Inserting audience members'
    AudienceMemberPopulate.insert(30)

    puts 'Inserting departments'
    DepartmentPopulate.insert(30)

    puts 'Inserting modules'
    DepartmentModulePopulate.insert

    puts 'Inserting department users'
    DepartmentUserPopulate.insert
  end
end

Dir[Rails.root.join('lib/populators/*.rb')].sort.each { |file| require file }

namespace :db do
  desc 'Erase and fill database'
  task populate: :environment do
    include Populators
    Rails.logger = Logger.new($stdout)

    puts 'Running seeds'
    Rake::Task['db:seed'].invoke

    UserPopulate.populate(500)
    AudienceMemberPopulate.populate
    DepartmentPopulate.populate
    DepartmentModulePopulate.populate
    DepartmentUserPopulate.populate
  end
end

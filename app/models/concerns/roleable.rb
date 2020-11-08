module Roleable
  extend ActiveSupport::Concern

  included do
    enum role: { responsible: 'responsible', collaborator: 'collaborator' }, _suffix: :role

    def self.human_roles
      roles.each_with_object({}) do |(key, _value), obj|
        obj[I18n.t("enums.roles.#{key}")] = key
      end
    end
  end
end

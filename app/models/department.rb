class Department < ApplicationRecord
    has_many :department_modules, dependent: :destroy

    validates :name, presence: true

    def modules
        department_modules
    end
end

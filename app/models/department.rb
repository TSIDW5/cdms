class Department < ApplicationRecord
    has_many :departments_modules, dependent: :destroy

    validates :name, presence: true
end

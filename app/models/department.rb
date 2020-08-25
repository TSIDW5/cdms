class Department < ApplicationRecord
    has_many :department_modules, dependent: :destroy

    validates :name, presence: true
    validates :initials, presence: true, uniqueness: true
    validates :local, presence: true
    validates :email, presence: true, uniqueness: true


    def modules
        department_modules
    end
end
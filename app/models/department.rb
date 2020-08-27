class Department < ApplicationRecord
   
    has_many :department_modules, dependent: :destroy

    validates :name, presence: true
    validates :initials, presence: true, uniqueness: true
    validates :local, presence: true
    validates :email, presence: true, uniqueness: true, format: {with: /\A\S+@.+\.\S+\z/, message: "inválido!"}
    validates :phone, presence: true, format: {with: /\A[1-9]{2}9[0-9]{8}\z|\A[1-9]{2}[0-9]{8}\z/, message: "inválido!"}
    
    def modules
        department_modules
    end

    
end
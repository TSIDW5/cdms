class Administrator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :user, :user_id, :role_id

  validates :user, presence: true
  validates :role_id, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save
    return false unless valid?

    User.update(@user_id, role_id: @role_id)
  end
end

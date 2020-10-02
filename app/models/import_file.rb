class ImportFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :file

  validates :file, presence: true
  validate :validates_extends?

  def initialize(attributes = {})
    if !attributes.nil?
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    else
      return false
    end
  end

  def validates_extends?
    if !self.file.nil?
      if (File.extname(self.file&.original_filename) == '.csv')
        return true
      end 
    end

    errors.add(:file, "erro na extenção") 
    return false  
  end

  def persisted?
    false
  end

end

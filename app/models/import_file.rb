class ImportFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :file

  validates :file, presence: true
  validates :validates_extends

  validates_format_of :file.original_filename, 
  :with => %r{\.csv$}i, :message => "file must be in .csv format", :multiline => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def validates_extends?
    if (File.extname(:file) != '.csv')
      errors.add(:role, I18n.t('errors.messages.taken'))
      return false
    end  
    return true  
  end

  def persisted?
    false
  end

end

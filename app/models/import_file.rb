class ImportFile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :file

  validates :file, presence: true
  validate :validates_extends?

  def initialize(attributes = {})
    attributes&.each do |name, value|
      send("#{name}=", value)
    end
  end

  def validates_extends?
    return if !file.nil? && File.extname(file&.original_filename) == '.csv'

    errors.add :file, I18n.t('views.audience_member.import.extension_invalid')
  end

  def persisted?
    false
  end
end

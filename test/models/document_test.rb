require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:front_text)
    should validate_presence_of(:back_text)

    should 'inclusion of category' do
      document = Document.new
      assert_not document.valid?
      assert_includes document.errors.messages[:category], I18n.t('errors.messages.inclusion')
    end
  end

  context 'category' do
    should define_enum_for(:category)
      .with_values(declaration: 'declaration', certification: 'certification')
      .backed_by_column_of_type(:enum)
      .with_suffix(:category)

    should 'human enum' do
      hash = { I18n.t('enums.categories.declaration') => 'declaration',
               I18n.t('enums.categories.certification') => 'certification' }

      assert_equal hash, Document.human_categories
    end
  end
end

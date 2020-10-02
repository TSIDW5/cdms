require 'test_helper'

class ImportFileTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:file)
  end
end

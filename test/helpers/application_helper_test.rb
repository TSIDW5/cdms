require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  context '#full_title' do
    should 'return the default title' do
      assert_equal 'SGCD', full_title
    end

    should 'return the full title' do
      assert_equal 'Home | SGCD', full_title('Home')
    end

    should 'return the full title with two arguments' do
      assert_equal 'Name | Acronyms', full_title('Name', 'Acronyms')
    end
  end

  context '#bootstrap_class_for' do
    should 'convert success key class alert-success' do
      assert_equal 'alert-success', bootstrap_class_for('success')
    end

    should 'convert error key class alert-danger' do
      assert_equal 'alert-danger', bootstrap_class_for('error')
    end

    should 'convert alert key class alert-warning' do
      assert_equal 'alert-warning', bootstrap_class_for('alert')
    end

    should 'convert notice key class alert-info' do
      assert_equal 'alert-info', bootstrap_class_for('notice')
    end

    should 'convert any key class to alert-key' do
      assert_equal 'alert-apocalypse', bootstrap_class_for('apocalypse')
    end
  end

  context '#user_role' do
    setup do
      @department_user_responsible = create(:department_user, :responsible)
      @department_user_collaborator = create(:department_user, :collaborator)
    end

    should 'return false' do
      assert_equal false, user_is_collaborator(@department_user_responsible.role)
    end
    
    should 'return true' do
      assert_equal true, user_is_collaborator(@department_user_collaborator.role)
    end
  end

end

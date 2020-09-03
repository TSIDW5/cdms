require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  context 'users' do
    setup do
      admin = create(:admin)
      login_as(admin, scope: :admin)
    end

    should 'list all' do
      users = create_list(:user, 3)
      visit admins_users_path

      within('table.table tbody') do
        users.each_with_index do |user, index|
          child = index + 1
          base_selector = "tr:nth-child(#{child})"

          assert_selector "#{base_selector} a[href='#{admins_user_path(user)}']", text: user.name
          assert_selector base_selector, text: user.email
          assert_selector base_selector, text: user.username
          assert_selector base_selector, text: user.register_number
          assert_selector base_selector, text: user.cpf
          assert_selector base_selector, text: I18n.t("views.status.#{user.active?}")

          assert_selector "#{base_selector} a[href='#{edit_admins_user_path(user)}']"
          assert_selector "#{base_selector} a[href='#{admins_user_path(user)}'][data-method='delete']"
        end
      end
    end

    should 'display' do
      visit admins_users_path

      assert_selector '#main-content .card-header', text: I18n.t('views.user.name.plural')
      assert_selector "#main-content a[href='#{new_admins_user_path}']", text: I18n.t('views.user.links.new')
    end
  end
end

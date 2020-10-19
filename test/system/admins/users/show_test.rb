require 'application_system_test_case'

class ShowTest < ApplicationSystemTestCase
  context 'user' do
    setup do
      user = create(:user, :manager)
      login_as(user, as: :user)

      @user = create(:user)
      visit admins_user_path(@user)
    end

    should 'display user data' do
      within('#main-content .card-body') do
        assert_text @user.name
        assert_text @user.email
        assert_text @user.username
        assert_text @user.register_number
        assert_text @user.cpf
        assert_text I18n.t("views.status.#{@user.active?}")
        assert_selector "img[src='#{@user.avatar.url}']"
      end
    end

    should 'display text and options' do
      within('#main-content .card-body') do
        assert_link(I18n.t('views.links.back'), href: admins_users_path)
        assert_link(I18n.t('views.links.edit'), href: edit_admins_user_path(@user))
      end
    end
  end
end

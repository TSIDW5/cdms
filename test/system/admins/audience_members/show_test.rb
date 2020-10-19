require 'application_system_test_case'

class ShowTest < ApplicationSystemTestCase
  context 'audience_member' do
    setup do
      user = create(:user, :manager)
      login_as(user, as: :user)

      @audience_member = create(:audience_member)
      visit admins_audience_member_path(@audience_member)
    end

    should 'display audience_member data' do
      within('#main-content .card-body') do
        assert_text @audience_member.name
        assert_text @audience_member.email
        assert_text @audience_member.cpf
      end
    end

    should 'display text and options' do
      within('#main-content .card-body') do
        assert_link(I18n.t('views.links.back'), href: admins_audience_members_path)
        assert_link(I18n.t('views.links.edit'), href: edit_admins_audience_member_path(@audience_member))
      end
    end
  end
end

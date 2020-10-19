require 'application_system_test_case'
require 'csv'

class CreateFromCsvTest < ApplicationSystemTestCase
  context 'audience_members' do
    setup do
      user = create(:user, :manager)
      login_as(user, as: :user)
    end

    context 'invalid' do
      should 'blank input file' do
        visit admins_new_audience_members_from_csv_path
        submit_form("button[type='submit']")

        assert_selector('div.alert.alert-danger', text: I18n.t('flash.actions.import.errors.blank'))
      end

      should 'file extension' do
        visit admins_new_audience_members_from_csv_path

        attach_file 'csv_file', FileHelper.image.path, make_visible: true
        submit_form("button[type='submit']")

        assert_selector('div.alert.alert-danger', text: I18n.t('flash.actions.import.errors.invalid'))
      end
    end

    should 'import registers from csv' do
      visit admins_new_audience_members_from_csv_path
      create(:audience_member, email: 'member5@utfpr.edu.br', cpf: '635.831.242-19')

      attach_file 'csv_file', FileHelper.csv('ams').path, make_visible: true
      submit_form("button[type='submit']")

      assert_selector('div.alert.alert-success',
                      text: I18n.t('flash.actions.import.m',
                                   resource_name: I18n.t('activerecord.models.audience_member.other')))

      assert_registered
      assert_already_registered
      assert_duplicates
      assert_invalids
    end
  end

  private

  def assert_registered
    within('#registered') do
      assert_selector('.badge', text: '3')
      find('a.card-options-collapse').click

      within('table.table tbody') do
        assert_content('Member 1')
        assert_content('Member 2')
        assert_content('Member 3')
      end
    end
  end

  def assert_already_registered
    within('#already_registered') do
      assert_selector('.badge', text: '2')
      find('a.card-options-collapse').click

      within('table.table tbody') do
        assert_content('Member 7')
        assert_content('Member 8')
      end
    end
  end

  def assert_duplicates
    within('#duplicates') do
      assert_selector('.badge', text: '2')
      find('a.card-options-collapse').click

      within('table.table tbody') do
        assert_content('Member 4')
        assert_content('Member 5')
      end
    end
  end

  def assert_invalids
    within('#invalids') do
      assert_selector('.badge', text: '3')
      find('a.card-options-collapse').click

      within('table.table tbody') do
        assert_content('member7@utfpr.edu.br')
        assert_content('Member 9')
        assert_content('Member 10')
      end
    end
  end
end

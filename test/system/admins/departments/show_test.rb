require 'application_system_test_case'

class ShowTest < ApplicationSystemTestCase
  context 'department' do
    setup do
      user = create(:user, :manager)
      login_as(user, as: :user)

      @department = create(:department)
      visit admins_department_path(@department)
    end

    should 'display department data' do
      within('#main-content .card.department-data .card-body') do
        assert_text @department.name
        assert_text @department.initials
        assert_text @department.phone
        assert_text @department.email
        assert_text @department.local
        assert_text @department.description
      end
    end

    should 'display text and options' do
      within('#main-content .card-body .footer') do
        assert_link(I18n.t('views.links.back'), href: admins_departments_path)
        assert_link(I18n.t('views.links.edit'), href: edit_admins_department_path(@department))
      end

      within('.card.modules .card-header') do
        assert_link(I18n.t('views.department_module.links.new'), href: new_admins_department_module_path(@department))
      end
    end

    should 'list modules' do
      modules = create_list(:department_module, 3, department: @department)
      visit admins_department_path(@department)

      within('.card.modules table.table tbody') do
        modules.each_with_index do |dp_module, index|
          child = index + 1
          base_selector = "tr:nth-child(#{child})"

          assert_selector base_selector, text: dp_module.name
          assert_selector base_selector, text: dp_module.description

          edit_path = edit_admins_department_module_path(@department, dp_module)
          destroy_path = admins_department_module_path(@department, dp_module)

          assert_selector "#{base_selector} a[href='#{edit_path}']"
          assert_selector "#{base_selector} a[href='#{destroy_path}'][data-method='delete']"
        end
      end
    end
  end
end

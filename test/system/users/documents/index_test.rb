require 'application_system_test_case'

class IndexTest < ApplicationSystemTestCase
  context 'document' do
    setup do
      user = create(:user, :manager)
      @department = create(:department)
      @department.department_users.create(user: user, role: :responsible)

      login_as(user, as: :user)
    end

    should 'list all' do
      document = create_list(:document, 3, :certification, department: @department)
      visit users_documents_path

      within('table.table tbody') do
        document.each_with_index do |document, index|
          child = index + 1
          base_selector = "tr:nth-child(#{child})"

          assert_selector base_selector, text: document.title

          assert_selector "#{base_selector} a[href='#{edit_users_document_path(document)}']"
          href = users_document_path(document)
          assert_selector "#{base_selector} a[href='#{href}'][data-method='delete']"
        end
      end
    end

    should 'search' do
      first_title = 'Primeiro título'
      second_title = 'Segundo título'

      FactoryBot.create(:document, title: first_title, department: @department, category: :certification)
      FactoryBot.create(:document, title: second_title, department: @department, category: :certification)

      visit users_documents_path

      fill_in 'search', with: second_title
      submit_form('button.submit-search')

      assert_selector 'tr:nth-child(1)', text: second_title
    end

    should 'display' do
      visit users_documents_path

      assert_selector '#main-content .card-header', text: I18n.t('activerecord.models.document.other')
      assert_selector "#main-content a[href='#{new_users_document_path}']",
                      text: I18n.t('views.document.links.new')
    end
  end
end

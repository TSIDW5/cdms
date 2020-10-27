require 'test_helper'

class Users::DocumentsControllerTest < ActionDispatch::IntegrationTest
  context 'authenticated' do

    setup do
      @document = create(:document, :certification)
      sign_in create(:user)
    end

    should 'get index' do
      get users_documents_path
      assert_response :success
      assert_active_link(href: users_documents_path)
    end

    should 'get new' do
      get new_users_document_path
      assert_response :success
      assert_active_link(href: users_documents_path)
    end

    should 'get edit' do
      get edit_users_document_path(@document)
      assert_response :success
      assert_active_link(href: users_documents_path)
    end

    should 'get preview' do
      get users_preview_document_path(@document)
      assert_response :success
    end
  end

  context 'unauthenticated' do
    should 'redirect to login when not authenticated' do
      assert_redirect_to(new_user_session_path)
    end
  end

  private

  def assert_redirect_to(redirect_to)
    requests.each do |method, routes|
      routes.each do |route|
        send(method, route)
        assert_redirected_to redirect_to
      end
    end
  end

  def requests
    {
        get: [users_documents_path, users_documents_path,
              edit_users_document_path(1), users_document_path(1)],
        post: [users_documents_path],
        patch: [users_document_path(1)],
        delete: [users_document_path(1)]
    }
  end
end

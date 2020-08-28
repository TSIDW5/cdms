require 'test_helper'

class Admins::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in create(:admin)
  end

  test "should get index" do
    get admins_users_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post admins_users_path, params: { user: { cpf: CPF.generate(true), name: @user.name, register_number: @user.register_number, status: @user.status, username: 'userTest' } }
    end

    assert_redirected_to admins_users_url
  end

  test "should show user" do
    get admins_user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch admins_user_url(@user), params: { user: { cpf: @user.cpf,  name: @user.name, register_number: @user.register_number, status: @user.status, username: @user.username } }
    assert_redirected_to admins_users_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete admins_user_path(@user)
    end
    assert_redirected_to admins_users_url
  end
end

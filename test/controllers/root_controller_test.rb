require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    User.collection.drop
    @user = User.create email: 'user@cszero.com', password: 'secret'
    Admin.collection.drop
    @admin = Admin.create email: 'admin@cszero.com', password: 'secret'
  end

  test "unlogged user or admin get links to sign ins" do
    get root_path
    assert_response :success
    assert_select 'a[href=?]', new_user_session_path, count: 1, text: 'Acesso atendente'
    assert_select 'a[href=?]', new_admin_session_path, count: 1, text: 'Acesso admin'
  end

  test "logged user is redirected to cases#index" do
    sign_in @user
    get root_path
    assert_redirected_to cases_path
  end

  test "logged admin is redirected to report#show" do
    sign_in @admin
    get root_path
    assert_redirected_to report_path
  end
end

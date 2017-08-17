require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    User.collection.drop
    Admin.collection.drop
    @admin = Admin.create email: 'admin@cszero.com', password: 'secret'
  end

  test "throws out unlogged admins" do
    get new_user_path
    assert_redirected_to new_admin_session_path
  end

  test "logged in users#new shows form and link to sign out" do
    sign_in @admin
    get new_user_path
    assert_response :success
    assert_select 'form', count: 1, action: users_path, method: 'POST'
    assert_select 'label[for=user_email]', text: 'Email'
    assert_select 'input#user_email', count: 1, type: 'email', name: 'user[email]'
    assert_select 'label[for=user_senha]', text: 'Senha'
    assert_select 'input#user_password', count: 1, type: 'password', name: 'user[password]'
    assert_select 'a[href=?]', destroy_admin_session_path, count: 1, text: 'Sair'
  end

  test "logged in users#create creates user and redirects to user#show" do
    sign_in @admin
    post users_path, params: { user: { email: 'user@cszero.com', password: 'secret' } }
    assert_redirected_to user_path(User.find_by email: 'user@cszero.com')
  end

  test "logged in users#show shows user email, and link to report and sign out" do
    sign_in @admin
    get user_path(User.create email: 'user@cszero.com', password: 'secret')
    assert_response :success
    assert_select 'span', id: 'email', text: 'user@cszero.com'
    assert_select 'a[href=?]', report_path, count: 1, text: 'Relatório'
    assert_select 'a[href=?]', destroy_admin_session_path, count: 1, text: 'Sair'
  end
end

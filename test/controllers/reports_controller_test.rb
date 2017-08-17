require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Admin.collection.drop
    @admin = Admin.create email: 'admin@cszero.com', password: 'secret'
  end

  test "throws out unlogged admins" do
    get report_path
    assert_redirected_to new_admin_session_path
  end

  test "logged in users#index links to create user and sign out" do
    sign_in @admin
    get report_path
    assert_response :success
    assert_select 'a[href=?]', new_user_path, count: 1, text: 'Criar novo atendente'
    assert_select 'a[href=?]', destroy_admin_session_path, count: 1, text: 'Sair'
  end
end

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Case.collection.drop
    Admin.collection.drop
    @admin = Admin.create email: 'admin@cszero.com', password: 'secret'
  end

  test "throws out unlogged admins" do
    get report_path
    assert_redirected_to new_admin_session_path
  end

  test "logged in report#show links to create user and sign out" do
    sign_in @admin
    get report_path
    assert_response :success
    assert_select 'a[href=?]', new_user_path, count: 1, text: 'Criar novo atendente'
    assert_select 'a[href=?]', destroy_admin_session_path, count: 1, text: 'Sair'
  end

  test "logged in report#show shows one report line for each day and uf in Case.report" do
    Case.create! type: 'email', uf: 'RJ', reason: 'suggestion', notes: 'Writes too much.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T10:34:45Z')
    Case.create! type: 'chat', uf: 'RJ', reason: 'compliment', notes: 'Writes too little.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T11:34:45Z')
    Case.create! type: 'chat', uf: 'DF', reason: 'suggestion', notes: 'A bit of cheese.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T12:34:45Z')
    Case.create! type: 'email', uf: 'AC', reason: 'compliment', notes: 'Mythical.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T10:34:45Z')
    Case.create! type: 'phone', uf: 'MG', reason: 'suggestion', notes: 'Ugly voice.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T11:34:45Z')
    Case.create! type: 'chat', uf: 'MG', reason: 'compliment', notes: 'Slow typer.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T15:34:45Z')
    sign_in @admin
    get report_path
    assert_select 'table' do
      Case.report.each do |day_uf|
        assert_select 'td', rowspan: day_uf.cases.length, text: day_uf._id.day
        assert_select 'td', rowspan: day_uf.cases.length, text: Case::BRAZIL_UFS[day_uf._id.uf.to_sym]
        day_uf.cases.each do |individual_case|
          assert_select 'td', text: individual_case.date.strftime('%H:%M:%S%z')
          assert_select 'td', text: Case::TYPES[individual_case.type.to_sym]
          assert_select 'td', text: Case::REASONS[individual_case.reason.to_sym]
          assert_select 'td', text: individual_case.notes
          assert_select 'td', text: individual_case.email
        end
      end
    end
  end
end

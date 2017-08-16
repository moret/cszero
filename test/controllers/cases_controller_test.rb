require 'test_helper'

class CasesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Case.collection.drop
    User.collection.drop
    @user = User.create email: 'user@cszero.com', password: 'secret'
  end

  test "throws out unlogged users" do
    get cases_path
    assert_redirected_to new_user_session_path
  end

  test "logged in cases#index redirect to cases#new" do
    sign_in @user
    get cases_path
    assert_redirected_to new_case_path
  end

  test "logged in cases#new shows form and link to sign out" do
    sign_in @user
    get new_case_path
    assert_response :success
    assert_select 'form', count: 1, action: cases_path, method: 'POST'
    assert_select 'label[for=case_Tipo]', text: 'Tipo'
    Case::TYPES.each do |key, value|
      assert_select 'input[type=radio]', name: 'case[type]', value: key
      assert_select 'label[for=?]', "case_type_#{key}"
    end
    assert_select 'label[for=case_UF]', text: 'Uf'
    assert_select('select', name: 'case[uf]') do
      Case::BRAZIL_UFS.each do |key, value|
        assert_select 'option', value: key, text: value
      end
    end
    assert_select 'label[for=case_Motivo]', text: 'Motivo'
    Case::REASONS.each do |key, value|
      assert_select 'input[type=radio]', name: 'case[reason]', value: key
      assert_select 'label[for=?]', "case_reason_#{key}"
    end
    assert_select 'label[for=case_Anotações]', text: 'Anotações'
    assert_select 'textarea', count: 1, type: 'password', name: 'case[notes]'
    assert_select 'a[href=?]', destroy_user_session_path, count: 1, text: 'Sair'
  end

  test "logged in cases#create creates case with user email and date, and redirects to cases#show" do
    sign_in @user

    travel_to Date.new(2017, 8, 16) do
      post cases_path, params: { case: { type: 'phone', uf: 'RJ', reason: 'question', notes: 'Nice guy.' } }
      newCase = Case.last
      assert_equal 'user@cszero.com', newCase.email
      assert_equal DateTime.now, newCase.date
      assert_redirected_to case_path(newCase)
    end
  end

  test "logged in cases#show shows case details, and link to cases#new and sign out" do
    sign_in @user
    travel_to Date.new(2017, 8, 16) do
      get case_path(Case.create type: 'phone', uf: 'RJ', reason: 'question', notes: 'Nice guy.', email: 'user@cszero.com')
      assert_response :success
      assert_select 'span', id: 'date', text: '2017-08-16T00:00:00+00:00'
      assert_select 'span', id: 'type', text: 'Telefone'
      assert_select 'span', id: 'uf', text: 'Rio de Janeiro'
      assert_select 'span', id: 'reason', text: 'Dúvida'
      assert_select 'textarea', text: 'Nice guy.'
      assert_select 'span', id: 'email', text: 'user@cszero.com'
      assert_select 'a[href=?]', new_case_path, count: 1, text: 'Iniciar novo atendimento'
      assert_select 'a[href=?]', destroy_user_session_path, count: 1, text: 'Sair'
    end
  end
end

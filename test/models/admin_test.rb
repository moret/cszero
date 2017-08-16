require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  setup do
    Admin.collection.drop
  end

  test "email must be unique" do
    firstAdmin = Admin.new email: 'admin@cszero.com', password: 'secret'
    firstAdmin.save!
    secondAdmin = Admin.new email: 'admin@cszero.com', password: 'anotherSecret'
    assert_not secondAdmin.save
    assert_equal 'is already taken', secondAdmin.errors.messages[:email][0]
  end

  test "empty will_save_change_to_email? for Rails 5 compatibility" do
    admin = Admin.new email: 'admin@cszero.com', password: 'secret'
    assert_nil admin.will_save_change_to_email?
  end
end

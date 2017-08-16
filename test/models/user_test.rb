require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    User.collection.drop
  end

  test "email must be unique" do
    firstUser = User.new email: 'user@cszero.com', password: 'secret'
    firstUser.save!
    secondUser = User.new email: 'user@cszero.com', password: 'anotherSecret'
    assert_not secondUser.save
    assert_equal 'is already taken', secondUser.errors.messages[:email][0]
  end

  test "empty will_save_change_to_email? for Rails 5 compatibility" do
    user = User.new email: 'user@cszero.com', password: 'secret'
    assert_nil user.will_save_change_to_email?
  end
end

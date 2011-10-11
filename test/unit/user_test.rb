require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the size of users" do
    assert_equal 3, User.count
  end

  test "the first user username" do
    assert_equal "david", User.first.username
  end

  test "user depent destroy with todo" do
    user = User.first
    assert_equal user, user.destroy
  end

  test "the size of user type" do
    assert_equal 2, User::USER_TYPE.size
  end

  test "last user full name" do
    user = User.last
    assert_equal "ahmad gulam", user.full_name
  end

  test "the first user id" do
    user = User.first
    assert_equal 127326141,user.id
  end
end

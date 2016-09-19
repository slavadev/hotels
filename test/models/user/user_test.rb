require 'test_helper'

class User::UserTest < ActiveSupport::TestCase
  test "User create success" do
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password

    # action
    user = User::User.new(email, password)
    user.save

    # check results
    assert_equal user.email, email
    assert_not_nil user.encrypted_password
    assert_not_nil user.salt
    assert_not_equal user.encrypted_password, password
    assert_equal user.password_is_right?(password), true
    assert_nil user.confirmed_at
  end

  test "User create without params fail" do
    # action
    user = User::User.new(nil, nil)
    user.save

    # check results
    assert user.invalid?
    assert_includes user.errors[:email], "can't be blank"
    assert_includes user.errors[:password], "can't be blank"
  end

  test "User create with wrong params fail" do
    # prepare
    email = password = Faker::Lorem.characters(5)

    # action
    user = User::User.new(email, password)
    user.save

    # check results
    assert user.invalid?
    assert_includes user.errors[:email], "is invalid"
    assert_includes user.errors[:password], "is too short (minimum is 6 characters)"
  end

  test "User create with already used email fail" do
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    User::User.new(email, password).save

    # action
    user = User::User.new(email, password)
    user.save

    # check results
    assert user.invalid?
    assert_includes user.errors[:email], "has already been taken"
  end
end

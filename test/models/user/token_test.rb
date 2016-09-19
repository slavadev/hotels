require 'test_helper'

class User::TokenTest < ActiveSupport::TestCase
  def setup
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    User::User.new(email, password).save
  end

  test "token create success" do
    # prepare
    user = User::User.find_by_id(1)
    type = Random.new.rand(0..2)

    # action
    token = User::Token.new(user, type)
    token.save

    # check results
    assert_equal token.user, user
    assert_equal token.token_type, type
    assert_equal token.is_expired, false
    assert_not_nil token.code
  end

  test "token create without params fail" do
    # action
    token = User::Token.new(nil, nil)
    token.save

    # check results
    assert token.invalid?
    assert_includes token.errors[:user], "can't be blank"
    assert_includes token.errors[:token_type], "can't be blank"
  end

  test "token create with wrong params fail" do
    # prepare
    user = User::User.find_by_id(1)
    type = Random.new.rand(3..20)

    # action
    token = User::Token.new(user, type)
    token.save

    # check results
    assert token.invalid?
    assert_includes token.errors[:token_type], "is not included in the list"
  end

  test "token expire success" do
    # prepare
    user = User::User.find_by_id(1)
    type = Random.new.rand(0..2)
    token = User::Token.new(user, type)
    token.save

    # action
    token.expire
    token.save

    # check results
    assert_equal token.is_expired, true
  end
end

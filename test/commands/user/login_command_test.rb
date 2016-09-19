require 'test_helper'

class User::LoginCommandTest < ActiveSupport::TestCase
  test "login success" do
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    user = User::User.new(email, password)
    user.save
    params = {email: email, password: password}

    # action
    command = User::LoginCommand.new(params)
    command.check_authorization
    command.check_validation
    result = command.execute

    # check results
    code = result[:token]
    token = User::Token.find_by_code(code)
    assert_not_nil token
    assert_equal token.user, user
    assert_equal token.token_type, User::Token::TYPE_LOGIN
    assert_equal token.is_expired, false
  end

  test "login wrong email or password fail" do
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    User::User.new(email, password).save
    password = Faker::Internet.password
    params = {email: email, password: password}

    # action
    command = User::LoginCommand.new(params)

    # check results
    assert command.invalid?
    assert_includes command.errors[:email], 'Wrong email or password'
  end
end

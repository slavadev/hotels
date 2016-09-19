require 'test_helper'

class User::RegisterCommandTest < ActiveSupport::TestCase
  test "register success" do
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    params = {email: email, password: password}

    # action
    command = User::RegisterCommand.new(params)
    command.check_authorization
    command.check_validation
    result = command.execute

    # check results
    id = result[:id]
    user = User::User.find_by_id(id)
    assert_not_nil user
    assert_equal user.email, email
    assert_equal user.password_is_right?(password), true
  end

  test "register validation errors fail" do
    # prepare
    params = {email: nil, password: nil}

    # action
    command = User::RegisterCommand.new(params)

    # check results
    assert_raises Core::Errors::ValidationError do
      command.execute
    end
  end
end

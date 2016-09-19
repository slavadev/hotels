require 'test_helper'

class User::UserIntegrationTest < ActionDispatch::IntegrationTest
  test "User life cycle success" do
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    params = {email: email, password: password}

    # action
    post '/api/v1/user/register', params: params

    # check results
    assert_response 200

    # action
    post '/api/v1/user/login', params: params

    # check results
    assert_response 200
    json = JSON.parse(response.body)
    code = json['token']
    token = User::Token.find_by_code(code)
    assert_not_nil token
  end

  test "user register validation fail" do
    # action
    post '/api/v1/user/register'

    # check results
    assert_response 422
    json = JSON.parse(response.body)
    assert_includes json['email'], "can't be blank"
    assert_includes json['password'], "can't be blank"
  end

  test "user login validation fail" do
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    params = {email: email, password: password}

    # action
    post '/api/v1/user/login', params: params

    # check results
    assert_response 422
    json = JSON.parse(response.body)
    assert_includes json['email'], "Wrong email or password"
  end
end

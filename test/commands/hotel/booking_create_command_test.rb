require 'test_helper'

class BookingCreateCommandTest < ActiveSupport::TestCase
  def setup
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    user = User::User.new(email, password)
    User::Token.new(user, User::Token::TYPE_LOGIN).save
  end

  test "create booking command success" do
    # prepare
    user = User::User.first
    token = User::Token.first.code
    hotel = Hotel::Hotel.first
    date = Time.new.to_date.to_s
    params = {token: token, hotel_id: hotel.id, date: date}
    command = Hotel::BookingCreateCommand.new(params)

    # action
    command.check_authorization
    command.check_validation
    result = command.execute

    # check results
    assert_equal result[:date], date
    assert_equal result[:hotel][:id], hotel.id
    assert_equal result[:hotel][:name], hotel.name
    assert_equal result[:user][:id], user.id
    assert_equal result[:user][:email], user.email
  end

  test "create booking with wrong params fail" do
    # prepare
    token = User::Token.first.code
    hotel_id = Random.new.rand(200..120000)
    date = '2012-20-20'
    params = {token: token, hotel_id: hotel_id, date: date}

    # action
    command = Hotel::BookingCreateCommand.new(params)

    # check results
    assert command.invalid?
    assert_includes command.errors[:hotel_id], 'does not exist'
    assert_includes command.errors[:date], 'is invalid'
  end

  test "create booking with wrong token fail" do
    # prepare
    token = Faker::Lorem.characters(10)
    params = {token: token}

    # action
    command = Hotel::BookingCreateCommand.new(params)

    # check results
    assert_raise Core::Errors::UnauthorizedError do
      command.check_authorization
    end
  end
end

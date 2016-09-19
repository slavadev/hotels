require 'test_helper'

class BookingDestroyCommandTest < ActiveSupport::TestCase
  def setup
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    user = User::User.new(email, password)
    date = Time.new.to_date
    User::Token.new(user, User::Token::TYPE_LOGIN).save
    hotel = Hotel::Hotel.first
    Hotel::Booking.new(user, hotel, date).save
  end

  test "destroy booking success" do
    # prepare
    token = User::Token.first.code
    booking = Hotel::Booking.first
    params = {token: token, id: booking.id}
    command = Hotel::BookingDestroyCommand.new(params)

    # action
    command.check_authorization
    command.check_validation
    command.execute

    # check results
    booking = Hotel::Booking.first
    assert_not_nil booking.deleted_at
  end

  test "destroy not yours booking fail" do
    # prepare
    ## second user
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    user = User::User.new(email, password)
    token = User::Token.new(user, User::Token::TYPE_LOGIN)
    token.save
    code = token.code
    booking = Hotel::Booking.first
    params = {token: code, id: booking.id}

    # action
    command = Hotel::BookingDestroyCommand.new(params)
    command.check_authorization

    # check results
    assert_raise Core::Errors::ForbiddenError do
      command.check_validation
    end
  end

  test "destroy not existing booking fail" do
    # prepare
    token = User::Token.first.code
    booking_id = Random.new.rand(30..300)
    params = {token: token, id: booking_id}


    # action
    command = Hotel::BookingDestroyCommand.new(params)
    command.check_authorization
    command.check_validation

    # check results
    assert_raise Core::Errors::NotFoundError do
      command.execute
    end
  end

  test "destroy booking with wrong token fail" do
    # prepare
    token = Faker::Lorem.characters(10)
    params = {token: token}

    # action
    command = Hotel::BookingDestroyCommand.new(params)

    # check results
    assert_raise Core::Errors::UnauthorizedError do
      command.check_authorization
    end
  end
end

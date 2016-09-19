require 'test_helper'

class Hotel::BookingMyCommandTest < ActiveSupport::TestCase
  def setup
    # user 1
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    user1 = User::User.new(email, password)
    date = Time.new.to_date
    User::Token.new(user1, User::Token::TYPE_LOGIN).save
    hotel = Hotel::Hotel.first
    Hotel::Booking.new(user1, hotel, date).save
    # user 2
    email = Faker::Internet.free_email
    user2 = User::User.new(email, password)
    Hotel::Booking.new(user2, hotel, date).save
    # user 3
    email = Faker::Internet.free_email
    user3 = User::User.new(email, password)
    Hotel::Booking.new(user3, hotel, date).save
  end

  test "index of my bookings success" do
    # prepare
    token = User::Token.first.code
    command = Hotel::BookingMyCommand.new({token: token})

    # action
    command.check_authorization
    command.check_validation
    result = command.execute

    # check results
    assert_equal result.size, 1
  end

  test "index of bookings of not existing user fail" do
    # prepare
    token = Faker::Lorem.characters(10)

    # action
    command = Hotel::BookingMyCommand.new({token: token})

    # check results
    assert_raise Core::Errors::UnauthorizedError do
      command.check_authorization
    end
  end
end

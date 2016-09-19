require 'test_helper'

class Hotel::BookingIndexCommandTest < ActiveSupport::TestCase
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

  test "index of bookings success" do
    # prepare
    command = Hotel::BookingIndexCommand.new({})

    # action
    result = command.execute

    # check results
    assert_equal result.size, 3
  end

  test "index of bookings of user success" do
    # prepare
    user = User::User.first
    command = Hotel::BookingIndexCommand.new({user_id: user.id})

    # action
    result = command.execute

    # check results
    assert_equal result.size, 1
  end

  test "index of bookings of not existing user fail" do
    # prepare
    user_id = 4

    # action
    command = Hotel::BookingIndexCommand.new({user_id: user_id})

    # check results
    assert_raise Core::Errors::NotFoundError do
      command.execute
    end
  end
end

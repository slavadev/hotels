require 'test_helper'

class Hotel::BookingTest < ActiveSupport::TestCase
  def setup
    # first user
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    User::User.new(email, password).save

    # second user
    email = Faker::Internet.free_email
    User::User.new(email, password).save
  end

  test "booking create success" do
    # prepare
    user = User::User.first
    hotel = Hotel::Hotel.first
    date = Time.now.to_date

    # action
    booking = Hotel::Booking.new(user, hotel, date)
    booking.save

    # check results
    assert_equal booking.user, user
    assert_equal booking.hotel, hotel
    assert_equal booking.date, date
  end

  test "booking create without params fail" do
    # action
    booking = Hotel::Booking.new(nil, nil, nil)
    booking.save

    # check results
    assert booking.invalid?
    assert_includes booking.errors[:user], "can't be blank"
    assert_includes booking.errors[:hotel], "can't be blank"
    assert_includes booking.errors[:date], "can't be blank"
  end

  test "booking create on the same date fail" do
    # prepare
    user = User::User.first
    hotel = Hotel::Hotel.first
    date = Time.now.to_date
    Hotel::Booking.new(user, hotel, date).save
    hotel = Hotel::Hotel.last

    # action
    booking = Hotel::Booking.new(user, hotel, date)
    booking.save

    # check results
    assert booking.invalid?
    assert_includes booking.errors[:date], "has already been taken"
  end

  test "booking create on the same date but different user success" do
    # prepare
    user = User::User.first
    hotel = Hotel::Hotel.first
    date = Time.now.to_date
    Hotel::Booking.new(user, hotel, date).save
    hotel = Hotel::Hotel.last
    user = User::User.last

    # action
    booking = Hotel::Booking.new(user, hotel, date)
    booking.save

    # check results
    assert booking.valid?
  end

  test "booking create on the same date when one is deleted success" do
    # prepare
    user = User::User.first
    hotel = Hotel::Hotel.first
    date = Time.now.to_date
    booking = Hotel::Booking.new(user, hotel, date)
    booking.deleted_at = Time.now
    booking.save

    # action
    booking = Hotel::Booking.new(user, hotel, date)
    booking.save

    # check results
    assert booking.valid?
  end
end

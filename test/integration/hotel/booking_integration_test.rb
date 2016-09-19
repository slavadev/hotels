require 'test_helper'

class Hotel::BookingIntegrationTest < ActionDispatch::IntegrationTest
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

  test "Booking life cycle success" do
    ### Index action
    # action
    get '/api/v1/bookings'

    # check results
    assert_response 200
    bookings = JSON.parse(response.body)
    assert_equal bookings.size, 3



    ### Index with user action
    # prepare
    user = User::User.first
    user_id = user.id.to_s

    # action
    get "/api/v1/bookings/#{user_id}"

    # check results
    assert_response 200
    bookings = JSON.parse(response.body)
    assert_equal bookings.size, 1


    ### Create action
    # prepare
    email = Faker::Internet.free_email
    password = Faker::Internet.password
    user = User::User.new(email, password)
    token = User::Token.new(user, User::Token::TYPE_LOGIN)
    token.save
    code = token.code
    date = Time.new.to_date.to_s
    hotel = Hotel::Hotel.first
    params = {token: code, hotel_id: hotel.id, date: date}

    # action
    post '/api/v1/bookings', params: params

    # check results
    assert_response 200
    booking = JSON.parse(response.body)
    assert_equal booking["date"], date
    assert_equal booking["hotel"]["id"], hotel.id
    assert_equal booking["hotel"]["name"], hotel.name
    assert_equal booking["user"]["id"], user.id
    assert_equal booking["user"]["email"], user.email


    ### Users bookings action
    # action
    get '/api/v1/bookings/my', params: {token: code}

    # check results
    assert_response 200
    bookings = JSON.parse(response.body)
    assert_equal bookings.size, 1


    ### Destroy action
    # prepare
    id = booking['id']

    # action
    delete "/api/v1/bookings/#{id}", params: {token: code}

    # check results
    assert_response 204
    get '/api/v1/bookings/my', params: {token: code}
    assert_response 200
    bookings = JSON.parse(response.body)
    assert_equal bookings.size, 0

  end
end

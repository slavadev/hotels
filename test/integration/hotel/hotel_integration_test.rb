require 'test_helper'

class Hotel::HotelIntegrationTest < ActionDispatch::IntegrationTest
  test "Hotel index success" do
    # action
    get '/api/v1/hotels'

    # check results
    assert_response 200
    hotels = JSON.parse(response.body)
    assert_equal hotels.size, 10
  end
end

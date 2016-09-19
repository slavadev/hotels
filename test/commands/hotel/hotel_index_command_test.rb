require 'test_helper'

class Hotel::HotelIndexCommandTest < ActiveSupport::TestCase
  test "index hotel command success" do
    # prepare
    command = Hotel::HotelIndexCommand.new({})

    # action
    command.check_authorization
    command.check_validation
    result = command.execute

    # check results
    assert_equal result.size, 10
  end

end

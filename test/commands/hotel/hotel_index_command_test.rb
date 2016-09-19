require 'test_helper'

class Hotel::HotelIndexCommandTest < ActiveSupport::TestCase
  test "index hotel command success" do
    # prepare
    command = Hotel::IndexCommand.new({})

    # action
    result = command.execute

    # check results
    assert_equal result.size, 10
  end

end

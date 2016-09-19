# Hotels controller
class Hotel::HotelsController < Core::Controller
  # List of hotels
  # @see Hotel::HotelIndexCommand
  def index
    command = Hotel::HotelIndexCommand.new(params)
    run(command)
  end
end

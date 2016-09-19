# Hotels controller
class Hotel::HotelsController < Core::Controller
  # List of hotels
  # @see Hotel::IndexCommand
  def index
    command = Hotel::IndexCommand.new(params)
    run(command)
  end
end

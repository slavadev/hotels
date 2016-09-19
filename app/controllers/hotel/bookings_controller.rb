# Bookings controller
class Hotel::BookingsController < Core::Controller
  # Creates a booking
  # @see Hotel::BookingCreateCommand
  def create
    command = Hotel::BookingCreateCommand.new(params)
    run(command)
  end

  # Destroys a booking
  # @see Hotel::BookingDestroyCommand
  def destroy
    command = Hotel::BookingDestroyCommand.new(params)
    run(command)
  end

  # List of bookings
  # @see Hotel::BookingIndexCommand
  def index
    command = Hotel::BookingIndexCommand.new(params)
    run(command)
  end

  # List of user bookings
  # @see Hotel::BookingIndexCommand
  def my
    command = Hotel::BookingMyCommand.new(params)
    run(command)
  end
end

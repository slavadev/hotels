# Contains methods to work with booking entities
class Hotel::BookingRepository < Core::Repository
  # Sets all variables
  # @see Hotel::Booking
  def initialize
    @model = Hotel::Booking
  end

  # Finds all hotels
  # @return [Array]
  def find_all
    @model.all
  end
end

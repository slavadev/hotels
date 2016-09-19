# Contains methods to work with hotel entities
class Hotel::HotelRepository < Core::Repository
  # Sets all variables
  # @see Hotel::Hotel
  def initialize
    @model = Hotel::Hotel
  end

  # Finds all hotels
  # @return [Array]
  def find_all
    @model.all
  end
end

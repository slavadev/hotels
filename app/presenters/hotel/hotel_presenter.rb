# Contains methods to show hotels
class Hotel::HotelPresenter < Core::Presenter
  # Gets hash from a hotel
  # @param [Event] hotel
  # @return [Hash]
  def hotel_to_hash(hotel)
    {
      id: hotel.id,
      name: hotel.name,
    }
  end

  # Gets hash from an hotels
  # @param [Array] hotels
  # @return [Hash]
  def hotels_to_hash(hotels)
    hotels.map do |hotel|
      hotel_to_hash(hotel)
    end
  end
end

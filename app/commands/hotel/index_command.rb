# Index of hotels command
class Hotel::IndexCommand < Core::Command
  # Sets all variables
  # @param [Object] params
  # @see Hotel::HotelRepository
  # @see Hotel::HotelPresenter
  def initialize(params)
    super(params)
    @hotel_repository = Hotel::HotelRepository.get
    @hotel_presenter = Hotel::HotelPresenter.get
  end

  # Rules for authorization
  # @return [Hash]
  def authorization_rules
    { token_type: nil }
  end

  # Runs command
  # @return [Hash]
  def execute
    hotels = @hotel_repository.find_all
    @hotel_presenter.hotels_to_hash(hotels)
  end
end

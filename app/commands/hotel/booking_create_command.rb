# Create a booking command
class Hotel::BookingCreateCommand < Core::Command
  attr_accessor :hotel_id, :date, :hotel_repository
  validates :hotel_id, presence: true, 'Core::Validator::Exists' => ->(x) { x.hotel_repository.find_by_id(x.hotel_id) }
  validate :if_date_is_valid

  # Sets all variables
  # @param [Object] params
  # @see Hotel::Booking
  # @see User::AuthorizationService
  # @see Hotel::HotelRepository
  # @see Hotel::BookingRepository
  # @see Hotel::BookingPresenter
  def initialize(params)
    super(params)
    @booking_model = Hotel::Booking
    @authorization_service = User::AuthorizationService.get
    @hotel_repository = Hotel::HotelRepository.get
    @booking_repository = Hotel::BookingRepository.get
    @booking_presenter = Hotel::BookingPresenter.get
  end

  # Checks that date param is valid
  def if_date_is_valid
    Date.parse(@date)
  rescue
    errors.add(:date, 'is invalid')
  end

  # Runs command
  # @return [Hash]
  def execute
    user = @authorization_service.get_user_by_token_code(token)
    hotel = @hotel_repository.find_by_id(hotel_id)
    parsed_date = Date.parse(date)
    booking = @booking_model.new(user, hotel, parsed_date)
    booking = @booking_repository.save!(booking)
    @booking_presenter.booking_to_hash(booking)
  end
end

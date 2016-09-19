# Index of my bookings command
class Hotel::BookingMyCommand < Core::Command
  # Sets all variables
  # @param [Object] params
  # @see User::AuthorizationService
  # @see Hotel::BookingRepository
  # @see User::UserRepository
  # @see Hotel::BookingPresenter
  def initialize(params)
    super(params)
    @authorization_service = User::AuthorizationService.get
    @booking_repository    = Hotel::BookingRepository.get
    @booking_presenter     = Hotel::BookingPresenter.get
  end

  # Runs command
  # @return [Hash]
  def execute
    user     = @authorization_service.get_user_by_token_code(token)
    bookings = @booking_repository.find_all_not_deleted_by_user(user)
    @booking_presenter.bookings_to_hash(bookings)
  end
end

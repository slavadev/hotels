# Index of bookings command
class Hotel::BookingIndexCommand < Core::Command
  attr_accessor :user_id

  # Sets all variables
  # @param [Object] params
  # @see Hotel::BookingRepository
  # @see User::UserRepository
  # @see Hotel::BookingPresenter
  def initialize(params)
    super(params)
    @booking_repository = Hotel::BookingRepository.get
    @user_repository = User::UserRepository.get
    @booking_presenter = Hotel::BookingPresenter.get
  end

  # Rules for authorization
  # @return [Hash]
  def authorization_rules
    { token_type: nil }
  end

  # Runs command
  # @return [Hash]
  def execute
    if user_id
      user = @user_repository.find_by_id!(user_id)
      bookings = @booking_repository.find_all_not_deleted_by_user(user)
    else
      bookings = @booking_repository.find_all_not_deleted
    end
    @booking_presenter.bookings_to_hash(bookings)
  end
end

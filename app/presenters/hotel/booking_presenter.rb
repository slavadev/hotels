# Contains methods to show bookings
class Hotel::BookingPresenter < Core::Presenter
  # Sets all services
  # @see Hotel::HotelPresenter
  # @see User::UserRepository
  def initialize
    @hotel_presenter = Hotel::HotelPresenter.get
    @user_presenter = User::UserPresenter.get
  end

  # Gets hash from a booking
  # @param [Hotel::Booking] booking
  # @return [Hash]
  def booking_to_hash(booking)
    {
      id: booking.id,
      date: booking.date.to_s,
      hotel: @hotel_presenter.hotel_to_hash(booking.hotel),
      user: @user_presenter.user_to_hash(booking.user),
    }
  end

  # Gets hash from bookings
  # @param [Array] bookings
  # @return [Hash]
  def bookings_to_hash(bookings)
    bookings.includes(:user, :hotel).map do |booking|
      booking_to_hash(booking)
    end
  end
end

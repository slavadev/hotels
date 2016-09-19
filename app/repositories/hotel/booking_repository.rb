# Contains methods to work with booking entities
class Hotel::BookingRepository < Core::Repository
  # Sets all variables
  # @see Hotel::Booking
  def initialize
    @model = Hotel::Booking
  end

  # Finds all not deleted bookings
  # @return [Array]
  def find_all_not_deleted
    @model.not_deleted
  end

  # Finds all not deleted bookings by user
  # @param [Object] user
  # @return [Array]
  def find_all_not_deleted_by_user(user)
    find_all_not_deleted.where(user: user)
  end
end

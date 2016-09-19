# Destroy a booking command
class Hotel::BookingDestroyCommand < Core::Command
  attr_accessor :id, :booking_repository
  validates :id, 'Core::Validator::Owner' => ->(x) { x.booking_repository.find_by_id(x.id) }

  # Sets all variables
  # @param [Object] params
  # @see Hotel::BookingRepository
  def initialize(params)
    super(params)
    @booking_repository = Hotel::BookingRepository.get
  end


  # Runs command
  # @return nil
  def execute
    booking = @booking_repository.find_not_deleted_by_id!(id)
    @booking_repository.delete(booking)
    nil
  end
end

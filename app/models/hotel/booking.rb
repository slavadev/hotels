# Booking class
# Fileds:
#  [Integer]           id
#  [Date]              date
#  [Time]              created_at
#  [Time]              updated_at
#  [Time]              deleted_at
#  [User::User]        user
#  [Hotel::Hotel]      hotel
class Hotel::Booking < ApplicationRecord
  extend Core::Deletable

  belongs_to :user, inverse_of: :bookings, class_name: 'User::User'
  belongs_to :hotel, inverse_of: :bookings, class_name: 'Hotel::Hotel'

  validates :user, :hotel, :date, presence: true
  validates_uniqueness_of :date, scope: :user, conditions: -> { where(deleted_at: nil) }

  # Creates a booking
  # @param [User::User] user
  # @param [Hotel::Hotel] hotel
  # @param [Date] date
  def initialize(user, hotel, date)
    super()
    self.user  = user
    self.hotel = hotel
    self.date  = date
  end
end

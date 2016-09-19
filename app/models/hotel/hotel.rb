# Hotel class
# Fileds:
#  [Integer]           id
#  [String]            name
#  [Time]              created_at
#  [Time]              updated_at
#  [Hotel::Booking][]  bookings
class Hotel::Hotel < ApplicationRecord
  has_many :bookings, class_name: 'Hotel::Booking'
  validates :name, presence: true
end

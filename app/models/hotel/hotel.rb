# Hotel class
# Fileds:
#  [Integer]           id
#  [String]            name
#  [Time]              created_at
#  [Time]              updated_at
class Hotel::Hotel < ApplicationRecord
  validates :name, presence: true
end

# User class
# Fileds:
#  [Integer]           id
#  [String]            email
#  [String]            encrypted_password
#  [String]            salt
#  [Time]              confirmed_at
#  [Time]              created_at
#  [Time]              updated_at
#  [User::Token][]     tokens
#  [Hotel::Booking][]  bookings
class User::User < ApplicationRecord
  has_many :tokens, class_name: 'User::Token'
  has_many :bookings, class_name: 'Hotel::Booking'

  attr_accessor :password

  validates :email, :salt, :encrypted_password, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, allow_nil: true, length: { minimum: 6 }, on: :update

  # Creates a user
  # @param [String] email
  # @param [String] password
  def initialize(email, password)
    super()
    self.email = email
    self.password = password
    self.confirmed_at = nil
  end

  # Sets the password
  # @param [String] password
  def password=(password)
    return if password.nil?
    @password = password
    generate_salt
    self.encrypted_password = encrypt_password(password)
  end

  # Checks the password
  # @param [String] password
  # @return [Boolean]
  def password_is_right?(password)
    encrypted_password == encrypt_password(password)
  end

  # Confirms email
  # @return [User::User]
  def confirm
    self.confirmed_at = DateTime.now.utc
  end

  private

  # Encrypts the password
  # @param [String] password
  # @return [String]
  def encrypt_password(password)
    Digest::SHA2.hexdigest(salt + password)
  end

  # Generates a salt
  def generate_salt
    self.salt = SecureRandom.base64(8)
  end
end

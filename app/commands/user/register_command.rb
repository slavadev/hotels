# Register command
class User::RegisterCommand < Core::Command
  attr_accessor :email, :password

  # Sets all services
  # @param [Object] params
  # @see User::UserRepository
  def initialize(params)
    super(params)
    @user_repository = User::UserRepository.get
  end

  # Rules for authorization
  # @return [Hash]
  def authorization_rules
    { token_type: nil }
  end

  # Runs command
  # @return [Hash]
  def execute
    user = User::User.new(email, password)
    user = @user_repository.save!(user)
    { id: user.id }
  end
end

# User controller
class User::UserController < Core::Controller
  # Method for registration
  # @see User::RegisterCommand
  def register
    command = User::RegisterCommand.new(params)
    run(command)
  end

  # Method for login
  # @see User::LoginCommand
  def login
    command = User::LoginCommand.new(params)
    run(command)
  end
end

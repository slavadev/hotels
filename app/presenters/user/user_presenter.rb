# Contains methods to show users
class User::UserPresenter < Core::Presenter
  # Gets hash from a user
  # @param [User::User] user
  # @return [Hash]
  def user_to_hash(user)
    {
      id: user.id,
      email: user.email,
    }
  end
end

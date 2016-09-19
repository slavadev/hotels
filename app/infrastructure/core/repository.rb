# Contains common methods for repositories
class Core::Repository
  include Core::Multitone

  # Saves an object
  # @param [ActiveRecord::Base] model
  # @return [ActiveRecord::Base]
  def save!(model)
    raise(Core::Errors::ValidationError, model) if model.invalid?
    model.save!
    model
  end

  # Deletes an object
  # @param [ActiveRecord::Base] model
  def delete(model)
    model.deleted_at = Time.now.utc
    save!(model)
  end

  # Finds an object by id
  # @param [Integer] id
  # @return [ActiveRecord::Base]
  def find_by_id(id)
    @model.find_by_id(id)
  end

  # Finds an object by id and raise exception otherwise
  # @param [Integer] id
  # @return [ActiveRecord::Base]
  def find_by_id!(id)
    model = find_by_id(id)
    raise(Core::Errors::NotFoundError, model) if model.nil?
    model
  end

  # Finds non deleted object by id
  # @param [Integer] id
  # @return [ActiveRecord::Base]
  def find_not_deleted_by_id(id)
    @model.not_deleted.find_by_id(id)
  end

  # Finds non deleted object by id and raise exception otherwise
  # @param [Integer] id
  # @return [ActiveRecord::Base]
  def find_not_deleted_by_id!(id)
    model = find_not_deleted_by_id(id)
    raise(Core::Errors::NotFoundError, model) if model.nil?
    model
  end

  # Finds actual objects owned by user
  # @param [User::User] user
  # @return [Array]
  def find_not_deleted_by_user(user)
    @model.not_deleted.where(user: user)
  end
end

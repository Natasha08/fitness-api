class User < ApplicationRecord
  has_secure_password

  def serializable_hash options
    super if options.present?

    super(only: [:id, :email])
  end
end

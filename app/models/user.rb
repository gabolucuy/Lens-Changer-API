class User < ApplicationRecord
  # encrypt password
  has_secure_password
  # Validations
  validates_presence_of :name, :last_name, :email, :phone, :password_digest

  has_many :children
end

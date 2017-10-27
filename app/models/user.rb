class User < ApplicationRecord
  # encrypt password
  has_secure_password
  # Validations
  validates_presence_of :name, :last_name, :email, :phone, :password_digest
  has_many :unsolved_problems
  has_many :children
  has_many :contacts
  has_many :friends, through: :contacts
  has_many :friends_requests
  has_many :applicants, through: :friends_requests
end

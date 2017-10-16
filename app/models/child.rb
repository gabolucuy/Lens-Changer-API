class Child < ApplicationRecord    
    # Validations
    validates_presence_of :name, :gender, :birthday
    belongs_to :user
  end
  
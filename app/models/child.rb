class Child < ApplicationRecord
    # Validations
    validates_presence_of :name, :gender, :birthday

    has_many :lagging_skills
  end

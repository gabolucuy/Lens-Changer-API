class Child < ApplicationRecord
    # Validations
    validates_presence_of :child_id, :name, :gender, :birthday
    belongs_to :user

    has_many :lagging_skills
    has_many :unsolved_problems
    has_one :alsup_share
end

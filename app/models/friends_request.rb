class FriendsRequest < ApplicationRecord
  validates_uniqueness_of :applicant,scope: :user
  belongs_to :user
  belongs_to :applicant,class_name:"User"
end

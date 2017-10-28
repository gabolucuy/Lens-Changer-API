class Contact < ApplicationRecord
  validates_uniqueness_of :friend,scope: :user
  belongs_to :user
  belongs_to :friend,class_name:"User"
end

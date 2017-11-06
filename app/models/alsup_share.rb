class AlsupShare < ApplicationRecord
	validates_uniqueness_of :user_id, :scope => :child_id
	belongs_to :user
	belongs_to :child


end

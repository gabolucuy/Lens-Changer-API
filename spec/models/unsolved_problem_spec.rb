require 'rails_helper'

RSpec.describe UnsolvedProblem, type: :model do

  it { should belong_to :user }


  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:solved) }
  it { should validate_presence_of(:unsolved_order) }
  it { should validate_presence_of(:unsolved_score) }
  it { should validate_presence_of(:user) }
  
end

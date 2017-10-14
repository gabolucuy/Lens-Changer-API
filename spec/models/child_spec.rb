require 'rails_helper'


# Test suite for User model
RSpec.describe Child, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:birthday) }  
end
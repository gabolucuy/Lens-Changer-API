FactoryGirl.define do
  factory :unsolved_problem do
    description { Faker::Lorem.sentence }
    solved { 'false'  }
    unsolved_order { Faker::Number.number(1) }
    unsolved_score { Faker::Number.number(1) }
    user { create :user }
  end
end

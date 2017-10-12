FactoryGirl.define do
  factory :user do
    name { Faker::Name.name_with_middle  }
    last_name { Faker::Name.last_name }
    phone { Faker::Number.number(10) }
    email 'foo@bar.com'
    password 'passwordNotHashed'
  end
end

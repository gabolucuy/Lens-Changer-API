FactoryGirl.define do
    factory :child do
      name { Faker::Name.name_with_middle  }
      op = rand(2)
      if(op == 1 )
        gender { "Male" }
      else
        gender { "Female" }
      end
      birthday { Faker::Date.between(20.years.ago, Date.today) }      
    end
  end
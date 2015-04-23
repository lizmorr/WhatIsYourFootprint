require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      role 'admin'
    end
  end

  factory :carbon_source do
    sequence(:name) { |n| "Heating oil #{n}" }
    conversion_factor 22
    units 'gallons'
  end

  factory :use_reason do
    name 'Home'
  end

  factory :usage do
    amount_used 10
    start_date "01/15/2015"
    end_date "02/15/2015"
    user
    carbon_source
    use_reason
  end
end

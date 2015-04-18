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
    name 'Heating oil'
    conversion_factor 0.01213
    conversion_units 'tons CO2 / gallon'
  end

  factory :use_reason do
    name 'Home'
  end

  factory :usage do
    amount_used 10
    units "gallons"
    start_date "01/15/2015"
    end_date "02/15/2015"
    user
    carbon_source
    use_reason
  end
end

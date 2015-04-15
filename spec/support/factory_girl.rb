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
    source 'Heating oil'
    conversion_factor 0.01213
    conversion_units 'tons CO2 / gallon'
  end

  factory :use_reason do
    name 'Home'
  end
end

FactoryGirl.define do
   factory :fishery do
    name Faker::Company.name
    contact_name Faker::Name.name 
    street Faker::Address.street_address
    line2 Faker::Address.street_address
    country Faker::Address.country
    region Faker::Address.state
    telephone Faker::PhoneNumber.phone_number
    postcode Faker::Address.postcode
    email Faker::Internet.email
    website Faker::Internet.url
    lat Faker::Address.latitude
    lng Faker::Address.longitude

    factory :fishery_with_waters do
   
      after(:create) do |fishery, evaluator|
          FactoryGirl.create_list(:water, 5, :fishery => fishery)
      end
    end
  end
end
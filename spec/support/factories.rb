FactoryGirl.define do
  factory :launcher do
    first_name "Gene"
    last_name "Parmesan"
    sequence(:email) { |n| "#{n}genep@geocities.com" }
    bio "Best private detective in all the land. - Lucille B."
  end
end

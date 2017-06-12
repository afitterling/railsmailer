FactoryGirl.define do
  factory :site do
    name "www.example.com"
    sequence(:uid) { |n| "site-#{n}" }
    recipient "foo@example.com"
  end
end

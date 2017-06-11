FactoryGirl.define do
  factory :mailer do
    sequence(:uid) { |n| "mailer-#{n}" }
  end
end

FactoryGirl.define do
  factory :device do
    last_used_key_sequence -1
    user
  end
end

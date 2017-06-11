FactoryGirl.define do
  factory :device_access_token do
    add_attribute(:sequence) { 1 }
    device
  end
end

class Site < ActiveRecord::Base
  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :recipient, presence: true
end

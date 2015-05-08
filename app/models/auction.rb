class Auction < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :ends_on, presence: true, ends_on: true
end

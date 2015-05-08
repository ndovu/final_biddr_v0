class Auction < ActiveRecord::Base
  validates :title, presence: true
end

class Auction < ActiveRecord::Base
  
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :ends_on, presence: true, ends_on: true
  validates :reserve_price, numericality: { greater_than_or_equal_to: 0, only_integer: true}
end

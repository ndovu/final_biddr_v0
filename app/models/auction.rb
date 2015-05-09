class Auction < ActiveRecord::Base
  
  belongs_to :user
  has_many :bids, dependent: :nullify
  # after_initialize :init

  validates :title, presence: true
  validates :description, presence: true
  validates :ends_on, presence: true, ends_on: true
  validates :reserve_price, numericality: { greater_than_or_equal_to: 0, only_integer: true}

  # def init
  #   self.bid ||= 0
  # end
end

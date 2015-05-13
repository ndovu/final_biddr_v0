class Auction < ActiveRecord::Base
  
  belongs_to :user
  has_many :bids, dependent: :nullify
  after_initialize :default_values

  validates :title, presence: true
  validates :description, presence: true
  validates :ends_on, presence: true, ends_on: true
  validates :reserve_price, numericality: { greater_than_or_equal_to: 0, only_integer: true}

  private
  
  def default_values
    if self.reserve_price == nil
      self.current_price ||= 0
    elsif  self.reserve_price > 0
      self.current_price ||= self.reserve_price
    else
      self.current_price ||= 0
    end
  end
end

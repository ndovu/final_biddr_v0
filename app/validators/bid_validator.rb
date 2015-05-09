class BidValidator < ActiveModel::Validator
  
  def validate(record)
    unless record.amount > record.auction.current_price
      record.errors[:name] << "Nice try! Bid is not higher than the current highest bid."
    end
    record.errors
  end
end
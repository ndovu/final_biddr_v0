class BidValidator < ActiveModel::Validator
  
  def validate(record)
    unless record.amount > record.auction.maximum("bid")
      record.errors[record] << "Nice try! Bid is not higher than the current highest bid."
    end
    record.errors
  end
end
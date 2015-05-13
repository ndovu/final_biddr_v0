class BidValidator < ActiveModel::Validator
  
  def validate(record)
    if record == nil
      record.errors[:name] << "Bid entered came in as nil."
    else    
      unless record.amount > record.auction.current_price
        record.errors[:name] << "Nice try! Bid is not higher than the current highest bid."
      end
      record.errors
    end
  end
end
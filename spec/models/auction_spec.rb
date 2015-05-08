require 'rails_helper'

RSpec.describe Auction, type: :model do
  def valid_attributes(new_attributes = {})
    attributes = {  title: 'BRAND NEW POTATO OMG must buy mint condition',
                    description: 'This potato is seriously the best',
                    ends_on: DateTime.new(2022,-11,-26,-20,-55,-54,'+7'),
                    reserve_price: 31415
                  }
    attributes.merge(new_attributes)
  end

  describe "Validations" do

    it 'requires a title' do
      auction = Auction.new(valid_attributes({ title: nil }))
      expect(auction).to be_invalid
    end

    it 'requires a description'

    it 'has and ends_on datetime that is in the future'

    it 'has a reserve_price greater than or equal to zero'
  end
end

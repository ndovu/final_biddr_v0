require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe "#validations" do
    it "only allows amount greater than or equal to zero" do
      bid = Bid.new(amount: -1)
      expect(bid).to be_invalid
    end
  end
end
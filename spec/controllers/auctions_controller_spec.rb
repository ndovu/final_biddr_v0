require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  def valid_attributes(new_attributes = {})
    attributes = {  title: 'BRAND NEW POTATO OMG must buy mint condition'
                    description: 'This potato is seriously the best'
                    ends_on: DateTime.new(2022,-11,-26,-20,-55,-54,'+7')
                    reserve_price: 31415
                  }
    attributes.merge(new_attributes)
  end

  describe "Validations" do

  end
end

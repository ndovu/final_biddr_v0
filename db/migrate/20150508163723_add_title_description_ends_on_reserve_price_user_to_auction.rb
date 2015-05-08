class AddTitleDescriptionEndsOnReservePriceUserToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :title, :string
    add_column :auctions, :description, :text
    add_column :auctions, :ends_on, :datetime
    add_column :auctions, :reserve_price, :integer
  end
end

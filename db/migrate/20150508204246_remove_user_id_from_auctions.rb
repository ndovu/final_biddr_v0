class RemoveUserIdFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :user_id, :integer
  end
end

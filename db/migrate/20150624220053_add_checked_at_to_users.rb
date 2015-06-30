class AddCheckedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :checked_instagram, :datetime
  end
end

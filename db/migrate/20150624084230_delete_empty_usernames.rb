class DeleteEmptyUsernames < ActiveRecord::Migration
  def change
    User.delete_all username: nil
  end
end

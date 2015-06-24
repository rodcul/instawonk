class DeleteEmptyUsernames < ActiveRecord::Migration
  def change
    User.delete all username: nil
  end
end

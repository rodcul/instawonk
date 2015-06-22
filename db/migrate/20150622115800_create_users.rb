class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :full_name
      t.string :profile_picture
      t.string :bio
      t.string :website
      t.integer :media
      t.integer :follows
      t.integer :followed_by

      t.timestamps null: false
    end
  end
end

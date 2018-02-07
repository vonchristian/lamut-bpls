class AddAvatarToBusinesses < ActiveRecord::Migration[5.1]
  def up
    add_attachment :businesses, :avatar
  end
  def down
    remove_attachment :businesses, :avatar
  end
end

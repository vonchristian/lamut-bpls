class AddAvatarToTaxpayers < ActiveRecord::Migration[5.1]
  def up
    add_attachment :taxpayers, :avatar
  end
  def down
    remove_attachment :taxpayers, :avatar
  end
end

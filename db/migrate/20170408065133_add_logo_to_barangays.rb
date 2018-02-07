class AddLogoToBarangays < ActiveRecord::Migration[5.1]
  def up
    add_attachment :barangays, :logo
  end
  def down
    remove_attachment :barangays, :logo
  end
end

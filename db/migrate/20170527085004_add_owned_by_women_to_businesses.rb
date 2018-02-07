class AddOwnedByWomenToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :owned_by_women, :boolean, default: false
  end
end

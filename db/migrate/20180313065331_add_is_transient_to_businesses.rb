class AddIsTransientToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :is_transient, :boolean, default: false
  end
end

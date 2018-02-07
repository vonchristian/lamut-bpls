class AddContactNumberToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :contact_number, :string
    add_column :businesses, :email, :string
  end
end

class AddOwnershipTypeToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :businesses, :ownership_type, foreign_key: true,  type: :uuid
  end
end

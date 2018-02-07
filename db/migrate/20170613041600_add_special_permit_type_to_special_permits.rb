class AddSpecialPermitTypeToSpecialPermits < ActiveRecord::Migration[5.1]
  def change
    add_column :special_permits, :special_permit_type, :integer
  end
end

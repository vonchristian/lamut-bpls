class AddFlatRateToSpecialPermits < ActiveRecord::Migration[5.1]
  def change
    add_column :special_permits, :flat_rate, :decimal
  end
end

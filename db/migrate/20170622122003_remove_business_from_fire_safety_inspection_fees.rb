class RemoveBusinessFromFireSafetyInspectionFees < ActiveRecord::Migration[5.1]
  def change
    remove_reference :fire_safety_inspection_fees, :business, foreign_key: true
  end
end

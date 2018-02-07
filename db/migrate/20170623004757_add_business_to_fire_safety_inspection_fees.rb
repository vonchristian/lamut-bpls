class AddBusinessToFireSafetyInspectionFees < ActiveRecord::Migration[5.1]
  def change
    add_reference :fire_safety_inspection_fees, :business, foreign_key: true, type: :uuid
  end
end

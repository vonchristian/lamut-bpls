class AddFireDeptCollectionToFireSafetyInspectionFees < ActiveRecord::Migration[5.1]
  def change
    add_reference :fire_safety_inspection_fees, :fire_dept_collection, foreign_key: true, type: :uuid
  end
end

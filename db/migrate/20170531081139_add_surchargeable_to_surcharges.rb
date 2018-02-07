class AddSurchargeableToSurcharges < ActiveRecord::Migration[5.1]
  def up
   change_table :surcharges do |t|
     t.references :surchargeable, :polymorphic => true, type: :uuid
   end
 end

 def down
   change_table :surcharges do |t|
     t.remove_references :surchargeable, :polymorphic => true, type: :uuid
   end
 end
end

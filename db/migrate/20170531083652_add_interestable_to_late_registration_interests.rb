class AddInterestableToLateRegistrationInterests < ActiveRecord::Migration[5.1]
  def up
   change_table :late_registration_interests do |t|
     t.references :interestable, :polymorphic => true, type: :uuid, index: { name: "index_on_late_registration_interests_interestable"}
   end
 end

 def down
   change_table :late_registration_interests do |t|
     t.remove_references :interestable, :polymorphic => true, type: :uuid, index: { name: "index_on_late_registration_interests_interestable"}
   end
 end
end

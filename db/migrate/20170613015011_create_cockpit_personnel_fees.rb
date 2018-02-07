class CreateCockpitPersonnelFees < ActiveRecord::Migration[5.1]
  def change
    create_table :cockpit_personnel_fees, id: :uuid do |t|
      t.string :name
      t.decimal :amount

      t.timestamps
    end
  end
end

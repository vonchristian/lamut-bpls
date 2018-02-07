class CreateMayorsPermitFeeBusinessCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :mayors_permit_fee_business_categories, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :mayors_permit_fee_business_categories, :name, unique: true
  end
end

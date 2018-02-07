class CreatePermitConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :permit_conditions, id: :uuid do |t|
      t.string :content
      t.boolean :default_condition, default: false

      t.timestamps
    end
  end
end

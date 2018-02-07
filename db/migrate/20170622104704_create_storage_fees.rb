class CreateStorageFees < ActiveRecord::Migration[5.1]
  def change
    create_table :storage_fees, id: :uuid do |t|
      t.belongs_to :fire_dept_collection, foreign_key: true, type: :uuid
      t.decimal :amount

      t.timestamps
    end
  end
end

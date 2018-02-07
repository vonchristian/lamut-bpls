class CreateFireDeptCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :fire_dept_collections, id: :uuid do |t|
      t.decimal :amount
      t.date :entry_date
      t.belongs_to :entry, foreign_key: true, type: :uuid
      t.belongs_to :collector, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end

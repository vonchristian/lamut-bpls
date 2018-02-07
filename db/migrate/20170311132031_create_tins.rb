class CreateTins < ActiveRecord::Migration[5.1]
  def change
    create_table :tins, id: :uuid do |t|
      t.integer :tinable_id
      t.string :tinable_type
      t.string :number, unique: true
      t.timestamps
    end
    add_index :tins, :tinable_id
    add_index :tins, :tinable_type
    add_index :tins, :number
  end
end

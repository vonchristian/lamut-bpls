class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :type
      t.boolean :contra
      t.string :code

      t.timestamps
    end
    add_index :accounts, :name, unique: true
    add_index :accounts, :type
    add_index :accounts, :code, unique: true
  end
end

class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :departments, :name, unique: true
  end
end

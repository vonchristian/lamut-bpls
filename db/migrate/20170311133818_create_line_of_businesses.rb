class CreateLineOfBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :line_of_businesses, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :line_of_businesses, :name, unique: true
  end
end

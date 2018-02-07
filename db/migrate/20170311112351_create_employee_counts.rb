class CreateEmployeeCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_counts, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.integer :number
      t.string :type

      t.timestamps
    end
    add_index :employee_counts, :type
  end
end

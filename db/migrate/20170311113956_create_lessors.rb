class CreateLessors < ActiveRecord::Migration[5.1]
  def change
    create_table :lessors, id: :uuid do |t|
      t.string :full_name
      t.string :address
      t.string :contact_number
      t.string :email
      t.belongs_to :business, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

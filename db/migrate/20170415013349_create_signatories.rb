class CreateSignatories < ActiveRecord::Migration[5.1]
  def change
    create_table :signatories, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :designation

      t.timestamps
    end
  end
end

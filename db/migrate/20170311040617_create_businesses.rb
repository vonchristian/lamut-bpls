class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end

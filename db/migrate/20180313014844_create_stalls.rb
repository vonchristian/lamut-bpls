class CreateStalls < ActiveRecord::Migration[5.1]
  def change
    create_table :stalls, id: :uuid do |t|
      t.belongs_to :public_market, foreign_key: true, type: :uuid
      t.string :number
      t.belongs_to :business, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :stalls, :number
  end
end

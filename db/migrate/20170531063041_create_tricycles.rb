class CreateTricycles < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycles, id: :uuid do |t|
      t.belongs_to :taxpayer, foreign_key: true, type: :uuid
      t.string :mtop_number
      t.string :plate_number

      t.timestamps
    end
  end
end

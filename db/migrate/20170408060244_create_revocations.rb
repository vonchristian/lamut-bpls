class CreateRevocations < ActiveRecord::Migration[5.1]
  def change
    create_table :revocations, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.datetime :date

      t.timestamps
    end
  end
end

class CreateSpecialPermits < ActiveRecord::Migration[5.1]
  def change
    create_table :special_permits, id: :uuid do |t|
      t.string :name
      t.decimal :rate
      t.timestamps
    end
  end
end

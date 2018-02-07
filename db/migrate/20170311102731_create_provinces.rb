class CreateProvinces < ActiveRecord::Migration[5.1]
  def change
    create_table :provinces, id: :uuid do |t|
      t.string :name, unique: true

      t.timestamps
    end
  end
end

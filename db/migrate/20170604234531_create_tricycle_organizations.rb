class CreateTricycleOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycle_organizations, id: :uuid do |t|
      t.string :name
      t.string :abbreviated_name

      t.timestamps
    end
    add_index :tricycle_organizations, :name, unique: true
    add_index :tricycle_organizations, :abbreviated_name, unique: true
  end
end

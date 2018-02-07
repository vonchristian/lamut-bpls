class CreateTricycleRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycle_requirements, id: :uuid do |t|
      t.string :name
      t.boolean :default_requirement, default: false
      t.belongs_to :department, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

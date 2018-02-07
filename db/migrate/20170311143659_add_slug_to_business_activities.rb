class AddSlugToBusinessActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :business_activities, :slug, :string
    add_index :business_activities, :slug, unique: true
  end
end

class AddSlugToBusinessRequirements < ActiveRecord::Migration[5.1]
  def change
    add_column :business_requirements, :slug, :string
    add_index :business_requirements, :slug, unique: true
  end
end

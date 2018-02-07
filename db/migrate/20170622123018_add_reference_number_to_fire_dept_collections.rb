class AddReferenceNumberToFireDeptCollections < ActiveRecord::Migration[5.1]
  def change
    add_column :fire_dept_collections, :reference_number, :string
  end
end

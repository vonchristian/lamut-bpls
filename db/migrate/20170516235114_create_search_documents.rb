class CreateSearchDocuments < ActiveRecord::Migration[5.1]
  def self.up
    say_with_time("Creating table for pg_search multisearch") do
      create_table :pg_search_documents do |t|
        t.text :content
        t.references :searchable, polymorphic: true, index: true, type: :uuid

        t.timestamps null: false
      end
    end
  end

  def self.down
    say_with_time("Dropping table for pg_search multisearch") do
      drop_table :pg_search_documents
    end
  end
end

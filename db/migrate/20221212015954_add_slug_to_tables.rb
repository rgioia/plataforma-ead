class AddSlugToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :slug, :string
    add_column :categories, :slug, :string
    add_column :courses, :slug, :string
    add_column :teachers, :slug, :string

    add_index :people, :slug, unique: true
    add_index :categories, :slug, unique: true
    add_index :courses, :slug, unique: true
    add_index :teachers, :slug, unique: true
  end
end

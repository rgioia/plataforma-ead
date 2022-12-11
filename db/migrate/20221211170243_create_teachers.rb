class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.boolean :active, default: true
      t.string :code
      t.references :person

      t.timestamps
    end
  end
end

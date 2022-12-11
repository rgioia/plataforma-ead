class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.date :start_date
      t.decimal :price
      t.integer :limit_subscriptions

      t.timestamps
    end
  end
end

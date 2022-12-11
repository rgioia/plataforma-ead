class AddColumnCategoryToCourse < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :category
  end
end

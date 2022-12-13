class AddColumnTeacherToCourse < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :teacher
  end
end

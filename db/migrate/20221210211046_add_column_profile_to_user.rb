class AddColumnProfileToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :integer, default: 1
  end
end

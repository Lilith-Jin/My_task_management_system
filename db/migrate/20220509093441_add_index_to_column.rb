class AddIndexToColumn < ActiveRecord::Migration[7.0]
  def change
    add_index :tasks, [:title, :state]
  end
end

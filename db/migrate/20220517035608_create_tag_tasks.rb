class CreateTagTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_tasks do |t|
      t.references :tag
      t.references :task

      t.timestamps
    end
  end
end

class AddUserToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :user_id, :bigint
    
    user = User.find_or_create_by(email: 'lilith@gmail.com') do |u|
      u.name = 'lilith'
      u.password = '123456'
      u.password_confirmation = '123456'
      u.role = 'admin'
    end

    Task.update_all(user_id: user.id)

    change_column_null :tasks, :user_id, false
  end
end

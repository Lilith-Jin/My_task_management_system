def login(user)
  visit '/'
  click_link I18n.t('user.action.login')
  has_css?('#login_field')
  login_data(user)
  click_button I18n.t('user.action.login')

end

def login_data(user)
  within('form') do
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password_confirmation', with: user.password_confirmation
  end
end

def fill_task_data
  within('form') do
    fill_in 'task_title', with: task.title
    fill_in 'task_content', with: task.content
    fill_in 'task_start_time', with: task.start_time
    fill_in 'task_end_time', with: task.end_time
    find_field('task_priority').find('option[selected]').text
    find_field('task_state').find('option[selected]').text
    fill_in 'task_tags_name', with: tags_name
  end
end
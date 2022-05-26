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
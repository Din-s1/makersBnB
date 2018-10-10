feature 'sign in' do
  scenario 'user enters a correct username and password and signs in' do
    visit '/'
    click_link 'sign up'
    fill_in 'username', with: 'Goku'
    fill_in 'email', with: 'goku@dbz.com'
    fill_in 'password', with: '123'
    click_button 'confirm'
    visit '/'
    click_link 'Sign in'
    fill_in 'username', with: 'Goku'
    fill_in 'password', with: '123'
    click_button 'sign in'
    expect(page).to have_content('Goku')
  end
end
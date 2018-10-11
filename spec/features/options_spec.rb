feature 'route options after log in' do
  scenario 'option page exists' do
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
    visit '/options'
    expect(page).to have_content('Goku')
    expect(page).to have_content("Please select one of the following options:")
    find_button('Host')
    find_button('Guest')
  end
end

feature 'sign up' do
  scenario 'user can sign up' do
    visit '/'
    click_link 'sign up'
    fill_in 'username', with: 'Goku'
    fill_in 'email', with: 'goku@dbz.com'
    fill_in 'password', with: '123'
    click_button 'confirm'
    expect(page).to have_content("Sign up successful")
  end
  

end
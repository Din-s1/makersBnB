feature 'list all guest pending requests' do
  scenario 'user makes a booking request and can see it' do
    TestSetup.db_setup
    visit '/'
    click_link 'sign up'
    fill_in 'username', with: 'Goku'
    fill_in 'email', with: 'goku@dbz.com'
    fill_in 'password', with: '123'
    click_button 'confirm'
    fill_in 'username', with: 'Goku'
    fill_in 'password', with: '123'
    click_button 'sign in'
    visit '/spaces'
    click_button 'Choose Dates'
    find('#stay').set('10/10/1992')
    click_button 'Confirm'
    expect(page).to have_content('Springfield')
    expect(page).to have_content('1992-10-10')
    expect(page).to have_content('flat')
  end
end
feature 'host page' do
  before do
    con = DBhelper.connect_to_db
    con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('house', 'Springfield', 44, 139, '06/06/06', 4);")
  end

  scenario 'displays list of properties to manager' do
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
    click_button 'Host'
    visit '/space_manager'
    # expect(page).to have_content('Space Manager')
    # expect(page).to have_content('Springfield')
  end

  # scenario 'host can add a new space to advertise' do
  #   visit '/space_manager'
  #   find_button('Add location')
  # end

end

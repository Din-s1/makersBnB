feature "showing all spaces" do
  before do
    con = DBhelper.connect_to_db
    con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('house', 'Springfield', 44, 1, '06/06/06', 4);")
  end

  scenario "user can see all spaces" do
    visit '/spaces'
    expect(page).to have_content("Springfield")
    expect(page).to have_content("$44.00")
    expect(page).to have_content("house")
  end

  scenario "user can click 'Choose Dates'" do
    visit '/spaces'
    click_on 'Choose Dates'
    expect(page).to have_content('Choose your stay date')
  end
end

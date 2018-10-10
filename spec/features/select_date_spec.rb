feature "selecting dates for confirmation" do
  before do
    con = DBhelper.connect_to_db
    con.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (1, 'house', 'Springfield', 44, 1, '06/06/06', 4);")
  end

  scenario "user can see space details" do
    visit '/spaces/1'
    expect(page).to have_content("Springfield")
    expect(page).to have_content("$44.00")
    expect(page).to have_content("house")
  end

  scenario "user can see a calendar of dates" do
    visit '/spaces/1'
    expect(page).to have_css("#stay")
  end

  scenario "user can view their requests" do
    visit '/spaces/1'
    click_on 'Confirm'
    expect(page).to have_content("Your Requests")
    expect(page).to have_content("Springfield")
    expect(page).to have_content("$44.00")
    expect(page).to have_content("house")
  end
end

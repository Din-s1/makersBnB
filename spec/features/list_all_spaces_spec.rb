feature "showing all spaces" do
  scenario "user can see all spaces" do
    con = DBhelper.connect_to_db
    con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('house', 'Springfield', 44, 1, '06/06/06', 4);")
    visit '/spaces'


    expect(page).to have_content("Springfield")
    expect(page).to have_content("$44.00")
    expect(page).to have_content("house")
  end
end

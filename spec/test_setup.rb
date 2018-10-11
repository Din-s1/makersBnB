module TestSetup
  def self.db_setup
    con = DBhelper.connect_to_db
    con.exec("INSERT INTO users (id, username, email, password) VALUES (1, 'Ghibli', 'studio@ghibli.com', 'Totoro')")
    con.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (1, 'flat', 'Springfield', 51, 1, '06/06/06', 4);")
  end
end
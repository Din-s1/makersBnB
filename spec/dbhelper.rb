module DBhelper
  def self.setup_test_db
    con = PG.connect(dbname: "makersbnb_test")
    con.exec("TRUNCATE users;")
    con.exec("TRUNCATE spaces, booking_requests, bookings;")
  end

  def self.connect_to_db
    database = ENV['ENVIRONMENT'] == 'test' ? 'makersbnb_test' : 'makersbnb'
    PG.connect(dbname: database)
  end
end

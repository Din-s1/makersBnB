module DBhelper
  def self.setup_test_db
    con = PG.connect(dbname: "makersbnb_test")
    con.exec("TRUNCATE users;")
    con.exec("TRUNCATE spaces;")
  end

  def self.connect_to_db
    database = ENV['ENVIRONMENT'] == 'test' ? 'makersbnb_test' : 'makersbnb'
    connection = PG.connect(dbname: database)
  end
end 

class Space

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end

    spaces = con.exec("SELECT * FROM spaces;")
    spaces.map do |row|
      {
        description: row['description'],
        location: row['location'],
        price: row['price'],
        host_id: row['host_id'],
        date: row['date'],
        guest_id: row['guest_id']
      }
    end

  end

end

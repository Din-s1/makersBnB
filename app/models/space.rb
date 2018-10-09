
class Space

  def self.all

    con = DBhelper.connect_to_db

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

  def self.create(description, location, price, host_id, date, guest_id)
    con = DBhelper.connect_to_db
    con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('#{description}','#{location}', #{price}, #{host_id}, '#{date}', #{guest_id});")
  end

  def self.find_space(host_id)
    con = DBhelper.connect_to_db
    find = con.exec("SELECT * FROM spaces WHERE host_id = #{host_id};")
    find.map do |row|
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


class Space
  CON = DBhelper.connect_to_db
  def self.all
    spaces = CON.exec("SELECT * FROM spaces;")
    spaces.map do |row|
      {
        space_id: row['id'],
        description: row['description'],
        location: row['location'],
        price: row['price'],
        host_id: row['host_id'],
        date: row['date'],
        guest_id: row['guest_id']
      }
    end
  end

  def self.create(description, location, price, host_id, date)
    CON.exec("INSERT INTO spaces(description, location, price, host_id, date) VALUES ('#{description}','#{location}', #{price}, #{host_id}, '#{date}');")
  end

  def self.find_spaces(host_id)
    find = CON.exec("SELECT * FROM spaces WHERE host_id = '#{host_id}';")
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

  def self.select_space(space_id)
    find = CON.exec("SELECT * FROM spaces WHERE id = #{space_id};")
    arr = find.map do |row|
      {
        space_id: row['id'],
        description: row['description'],
        location: row['location'],
        price: row['price'],
        host_id: row['host_id'],
        date: row['date'],
        guest_id: row['guest_id']
      }
    end
    arr.first
  end

  def self.delete_space(space_id)
    CON.exec("DELETE FROM spaces WHERE id = #{space_id}")
  end

end

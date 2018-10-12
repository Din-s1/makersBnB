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
        id: row['id'],
        description: row['description'],
        location: row['location'],
        price: row['price'],
        date: row['date'],
        host_id: row['host_id'],
        guest_id: row['guest_id']
      }
    end
  end

  def self.select_space(space_id)
    find = CON.exec("SELECT * FROM spaces WHERE id = #{space_id};")
    arr = find.map do |row|
      {
        id: row['id'],
        description: row['description'],
        location: row['location'],
        price: row['price'],
        date: row['date'],
        host_id: row['host_id'],
        guest_id: row['guest_id']
      }
    end
    arr.first
  end

  def self.delete_space(space_id)
    CON.exec("DELETE FROM spaces WHERE id = #{space_id}")
  end

  def self.list_with_requests(host_id)
    result = find_spaces(host_id)

    result.each do |space|
      space[:booking_requests] = CON.exec("
        SELECT
          booking_requests.id,
          booking_requests.date
        FROM 
          spaces
        INNER JOIN booking_requests ON spaces.id = booking_requests.space_id
        WHERE 
          spaces.host_id = '#{host_id}'
        AND
          spaces.id = '#{space[:id]}'
        AND 
          booking_requests.status IS NULL
      ").map do |row| 
        {
          booking_id: row['id'], 
          booking_date: row['date'] 
        }
      end
    end

    return result
  end

end

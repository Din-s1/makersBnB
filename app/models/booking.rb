class Booking
  CON = DBhelper.connect_to_db

  def self.create(space_id, host_id, guest_id, date, total_price)
    CON.exec("INSERT INTO bookings (space_id, host_id, guest_id, date, total_price) VALUES (#{space_id}, '#{host_id}', '#{guest_id}', '#{date}', '#{total_price}')")
  end

  def self.all
    result = CON.exec("SELECT * FROM bookings")
    result.map do |row| {
        space_id: row['space_id'],
        host_id: row['host_id'],
        guest_id: row['guest_id'],
        date: row['date'],
        total_price: row['total_price']
      }
    end
  end

  def self.view(host_id)
    CON.exec("SELECT * FROM bookings").map do |row|
      {
        space_id: row['space_id'],
        host_id: row['host_id'],
        guest_id: row['guest_id'],
        date: row['date'],
        total_price: row['total_price']
      }
    end
  end
end

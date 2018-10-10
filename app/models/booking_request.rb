class BookingRequest
  CON = DBhelper.connect_to_db
  def self.create(space_id, host_id, guest_id, date)
    CON.exec("INSERT INTO booking_requests (space_id, host_id, guest_id, date) VALUES ('#{space_id}', '#{host_id}', '#{guest_id}', '#{date}')")
  end

  def self.all
    result = CON.exec("SELECT * FROM booking_requests")
    result.map do |row|
      {
        space_id: row['space_id'],
        host_id: row['host_id'],
        guest_id: row['guest_id'],
        date: row['date']
      }
    end
  end

  def self.view_booking_request(host_id)
    CON.exec("SELECT * FROM booking_requests").map do |row|
      {
        space_id: row['space_id'],
        host_id: row['host_id'],
        guest_id: row['guest_id'],
        date: row['date']
      }
    end
  end


end

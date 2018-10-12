class BookingRequest
  CON = DBhelper.connect_to_db

  def self.create(space_id, host_id, guest_id, date)
    CON.exec("
      INSERT INTO 
        booking_requests (space_id, host_id, guest_id, date) 
      VALUES
        ('#{space_id}', '#{host_id}', '#{guest_id}', '#{date}')
    ")
  end

  def self.all
    result = CON.exec("
      SELECT 
        * 
      FROM 
        booking_requests
    ")

    result.map do |row|
      {
        space_id: row['space_id'],
        host_id: row['host_id'],
        guest_id: row['guest_id'],
        date: row['date']
      }
    end
  end

  def self.view_booking_requests(host_id)
    result = CON.exec("
      SELECT 
        * 
      FROM 
        booking_requests 
      WHERE 
        host_id = '#{host_id}'
    ")
    
    result.map do |row|
      {
        space_id: row['space_id'],
        host_id: row['host_id'],
        guest_id: row['guest_id'],
        date: row['date']
      }
    end
  end

  def self.guest_pending_requests(guest_id) 
    result = CON.exec("
      SELECT 
        booking_requests.date, 
        spaces.description, 
        spaces.location
      FROM 
        booking_requests
        INNER JOIN spaces ON booking_requests.space_id = spaces.id
        WHERE 
          booking_requests.guest_id = '#{guest_id}'
          AND booking_requests.status IS NULL
    ")
    
    result.map do |row|
      {
        booking_date: row['date'],
        booking_description: row['description'],
        booking_location: row['location']
      }
    end
  end

  def self.accept(booking_request_id)
    CON.exec("
      UPDATE
        booking_requests
      SET 
        status = TRUE
      WHERE
        id = #{booking_request_id}
    ")
  end

  def self.decline(booking_request_id)
    CON.exec("
      UPDATE
        booking_requests
      SET 
        status = FALSE
      WHERE
        id = #{booking_request_id}
    ")
  end
end

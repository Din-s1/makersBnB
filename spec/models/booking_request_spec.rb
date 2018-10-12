require './app/models/booking_request.rb'

describe BookingRequest do
  let(:conn) { DBhelper.connect_to_db }
  
  describe '.create' do
    it 'creates a row in the booking_request table' do
      conn.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      BookingRequest.create(333, 1, 7, '06/06/07')
      expect(conn.exec('SELECT * FROM booking_requests')[0]).to include({
        'space_id' => '333',
        'host_id' => '1', 
        'guest_id' => '7', 
        'date' => '2007-06-06'
      })
    end
  end

  describe '.all' do
    it 'lists all the booking_request rows in the booking table' do
      conn.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      BookingRequest.create(333, 1, 7, '06/06/07')
      expect(BookingRequest.all).to eq([{
        space_id: '333',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06'
      }])
    end
  end

  describe '.view_booking_request' do
    it 'lists an individual booking request' do
      conn.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      BookingRequest.create(333, 1, 7, '06/06/07')
      conn.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (455, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      BookingRequest.create(455, 1, 7, '06/06/07')
      expect(BookingRequest.view_booking_requests(1)).to eq([{
        space_id: '333',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06'
      }, 
      {
        space_id: '455',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06'
      }
    ])
    end
  end

  describe '.guest_pending_requests' do
    it 'should list only the pending booking requests for one user' do
      conn.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      BookingRequest.create(333, 1, 7, '06/06/07')      
      expect(BookingRequest.guest_pending_requests(7)).to eq([{
        booking_date: '2007-06-06',
        booking_description: 'flat',
        booking_location: 'Springfield'
      }])
    end
  end

  describe '.accept' do
    it 'should accept a booking request and change its status to true' do
      TestSetup.db_setup
      conn.exec("INSERT INTO booking_requests (id, space_id, host_id, guest_id, date) VALUES (1, 1, '1', '1', '1/1/11')")
      BookingRequest.accept(1)
      expect(conn.exec('SELECT status FROM booking_requests WHERE id = 1').first['status']).to eq('t')
    end
  end

  describe '.decline' do
    it 'should decline a booking request and change its status to false' do
      TestSetup.db_setup
      conn.exec("INSERT INTO booking_requests (id, space_id, host_id, guest_id, date) VALUES (1, 1, '1', '1', '1/1/11')")
      BookingRequest.decline(1)
      expect(conn.exec('SELECT status FROM booking_requests WHERE id = 1').first['status']).to eq('f')
    end
  end

end

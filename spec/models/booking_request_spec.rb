require './app/models/booking_request.rb'

describe BookingRequest do
  let(:connect) { DBhelper.connect_to_db }
  describe '.create' do
    it 'creates a row in the booking_request table' do
      connect.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      BookingRequest.create(333, 1, 7, '06/06/07')
      expect(connect.exec('SELECT * FROM booking_requests')[0]).to include({
        'space_id' => '333',
        'host_id' => '1', 
        'guest_id' => '7', 
        'date' => '2007-06-06'
      })
    end
  end

  describe '.all' do
    it 'lists all the booking_request rows in the booking table' do
      connect.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      BookingRequest.create(333, 1, 7, '06/06/07')
      booking_request_id = connect.exec("")
      expect(BookingRequest.all).to eql([{
        space_id: '333',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06'
      }])
    end
  end

  describe '.view_booking_request' do
    it 'lists an individual booking request' do
      
    end
  end

  describe '.update' do
    it 'updates the booking request table' do
      
    end
  end
end

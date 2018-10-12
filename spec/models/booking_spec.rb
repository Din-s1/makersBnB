require './app/models/booking.rb'

describe Booking do
  let(:conn) { DBhelper.connect_to_db }

  before do
    conn.exec("
      INSERT INTO 
        spaces(id, description, location, price, host_id, date, guest_id) 
      VALUES 
        (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7)
    ")
  end
  
  describe '.create' do
    it 'Should create confirmed booking' do
      Booking.create(333, 1, 7, '06/06/06', 100)

      expect(conn.exec('SELECT * FROM bookings').first).to include({
        'space_id' => '333',
        'host_id' => '1', 
        'guest_id' => '7', 
        'date' => '2006-06-06',
        'total_price' => '$100.00'
      })
    end
  end

  describe '.all' do
    it 'Should show all confirmed bookings' do
      Booking.create(333, 1, 7, '06/06/07', 100)

      expect(Booking.all.first).to include({
        space_id: '333',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06',
        total_price: '$100.00'
      })
    end
  end

  describe '.view' do
    it 'Should show confirmed guest bookings' do
      Booking.create(333, 1, 7, '06/06/07', 100)

      expect(Booking.view(7).first).to include({
        space_id: '333',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06',
        total_price: '$100.00'
      })
    end
  end
end

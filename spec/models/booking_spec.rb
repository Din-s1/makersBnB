require './app/models/booking.rb'

describe Booking do
  let(:connect) { DBhelper.connect_to_db }
  describe '.create' do
    it 'Should create confirmed booking' do
      connect.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      Booking.create(333, 1, 7, '06/06/07', 100)
      expect(connect.exec('SELECT * FROM bookings')[0]).to include({
        'space_id' => '333',
        'host_id' => '1', 
        'guest_id' => '7', 
        'date' => '2007-06-06',
        'total_price' => '$100.00'
      })
    end
  end

  describe '.all' do
    it 'Should show all confirmed bookings' do
      connect.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      Booking.create(333, 1, 7, '06/06/07', 100)
      expect(Booking.all).to eql([{
        space_id: '333',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06',
        total_price: '$100.00'
      }])
    end
  end

  describe '.view' do
    it 'Should show specific confirmed bookings' do
      connect.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      Booking.create(333, 1, 7, '06/06/07', 100)
      connect.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (455, 'flat', 'Springfield', 51, 1, '06/06/06', 7);")
      Booking.create(455, 1, 7, '06/06/07', 100)
      expect(Booking.view(1)).to eql([{
        space_id: '333',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06',
        total_price: '$100.00'
      }, 
      {
        space_id: '455',
        host_id: '1',
        guest_id: '7',
        date: '2007-06-06',
        total_price: '$100.00'
      }
    ])
    end
  end

end

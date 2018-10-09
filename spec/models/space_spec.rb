require './app/models/space.rb'

describe Space do
  let(:con) { DBhelper.connect_to_db }
  describe '.create' do
    it "creates a space row in the spaces db" do
      Space.create('flat','Springfield', 51, 1, '06/06/06', 4)
      expect(Space.all).to include({
              description: 'flat',
              location: 'Springfield',
              price: '$51.00',
              host_id: '1',
              date: '2006-06-06',
              guest_id: '4'
            })
    end
  end

  describe '.all' do
    it "retrieves all spaces in the spaces db" do
      con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('flat', 'Springfield', 51, 1, '06/06/06', 4);")
      spaces = Space.all
      expect(spaces).to include({
              description: 'flat',
              location: 'Springfield',
              price: '$51.00',
              host_id: '1',
              date: '2006-06-06',
              guest_id: '4'
            })
    end
  end

  describe '.find_space' do
    it 'finds user room based on user id' do
      con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('flat', 'Springfield', 51, 1, '06/06/06', 4);")
      con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('house', 'Drury Lane', 44, 3, '11/14/12', 6);")
      expect(Space.find_spaces(1)).to eql([{
              description: 'flat',
              location: 'Springfield',
              price: '$51.00',
              host_id: '1',
              date: '2006-06-06',
              guest_id: '4'
            }])
    end
  end

  describe '.delete_space' do
    it 'deletes a user room based on space id' do
      con.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (333, 'flat', 'Springfield', 51, 1, '06/06/06', 4);")
      con.exec("INSERT INTO spaces(id, description, location, price, host_id, date, guest_id) VALUES (555, 'house', 'Drury Lane', 44, 3, '11/14/12', 6);")
      Space.delete_space(333)
      expect(Space.all).not_to include({
              description: 'flat',
              location: 'Springfield',
              price: '$51.00',
              host_id: '1',
              date: '2006-06-06',
              guest_id: '4'
            })
    end
  end

end

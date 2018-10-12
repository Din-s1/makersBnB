require './app/models/space.rb'

describe Space do
  let(:conn) { DBhelper.connect_to_db }

  before do
    conn.exec("
      INSERT INTO 
        spaces(description, location, price, host_id, date, guest_id) 
      VALUES 
        ('flat', 'Springfield', 51, 1, '06/06/06', 4);
    ")
  end

  describe '.create' do
    it "creates a space row in the spaces db" do
      Space.create('apartment','London', 99, 1, '05/05/05')
      expect(conn.exec('SELECT * FROM spaces')[1]).to include({
              'description' => 'apartment',
              'location' => 'London',
              'price' => '$99.00',
              'host_id' => '1',
              'date' => '2005-05-05',
            })
    end
  end

  describe '.all' do
    it "retrieves all spaces in the spaces db" do
      space_id = conn.exec('
        SELECT 
          id 
        FROM 
          spaces
      ').first['id']

      expect(Space.all).to include({
              space_id: space_id,
              description: 'flat',
              location: 'Springfield',
              price: '$51.00',
              host_id: '1',
              date: '2006-06-06',
              guest_id: '4'
            })
    end
  end

  describe '.find_spaces' do
    it 'finds user room based on user id' do
      expect(Space.find_spaces(1).first).to include({
              description: 'flat',
              location: 'Springfield',
              price: '$51.00',
              host_id: '1',
              date: '2006-06-06',
              guest_id: '4'
            })
    end
  end

  describe '.select_space' do
    it 'it finds a room based on space id' do
      space_id = conn.exec("
        SELECT 
          id 
        FROM 
          spaces
      ").first['id']
      expect(Space.select_space(space_id)).to include({
              description: 'flat',
              location: 'Springfield',
              price: '$51.00',
              host_id: '1',
              date: '2006-06-06',
              guest_id: '4'
            })
    end
  end

  describe '.delete_space' do
    it 'deletes a user room based on space id' do
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

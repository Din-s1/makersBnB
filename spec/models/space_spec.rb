require './app/models/space.rb'

describe Space do

  # describe '.create' do
  #   it "creates a space row in the spaces db" do
  #     space = Space.new
  #     space.create("Springfield", "flat", 51, '06/06/06', 1, 4)
  #   end
  # end

  describe '.all' do
    it "retrieves all spaces in the spaces db" do
      con = PG.connect(dbname: "makersbnb_test")
      con.exec("INSERT INTO spaces(description, location, price, host_id, date, guest_id) VALUES ('flat', 'Springfield', 51, 1, '06/06/06', 4);")
      spaces = Space.all
      expect(spaces).to include ({
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

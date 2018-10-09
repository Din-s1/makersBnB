require './app/models/users.rb'

describe User do
  let(:connect) { DBhelper.connect_to_db }

  describe '.create' do
    it 'create a user' do
      User.create('Ghibli','studio@ghibli.com','Totoro')
      expect(connect.exec('SELECT username FROM users')).to eq('Ghibli')
      expect(connect.exec('SELECT email FROM users')).to eq('studio@ghibli.com')
      expect(connect.exec('SELECT password FROM users')).to eq('Totoro')
    end
  end
end

require './app/models/user.rb'

describe User do
  let(:connect) { DBhelper.connect_to_db }

  describe '.create' do
    it 'create a user' do
      User.create('Ghibli','studio@ghibli.com','Totoro')
      expect(connect.exec('SELECT username, email, password FROM users')).to include({
        'username' => 'Ghibli',
        'email' => 'studio@ghibli.com', 
        'password' => 'Totoro'
      })
    end
  end
end

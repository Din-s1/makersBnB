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

  describe '.view' do
    it 'shows all users' do
      connect.exec("INSERT INTO users (username, email, password) VALUES ('Ghibli','studio@ghibli.com','Totoro')")
      expect(User.view('Ghibli')[0]).to include({
        'username' => 'Ghibli',
        'email' => 'studio@ghibli.com', 
        'password' => 'Totoro'
      })
    end
  end

end

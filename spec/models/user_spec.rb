require './app/models/user.rb'

describe User do
  let(:connect) { DBhelper.connect_to_db }

  describe '.create' do
    it 'create a user' do
      User.create('Ghibli', 'studio@ghibli.com', 'Totoro')
      expect(connect.exec('SELECT username, email, password FROM users')).to include({
        'username' => 'Ghibli',
        'email' => 'studio@ghibli.com', 
        'password' => 'Totoro'
      })
    end

    it "doesn't allow the same email to be entered twice" do
      User.create('Ghibli', 'studio@ghibli.com', 'Totoro')
      expect { User.create('Ghibli2', 'studio@ghibli.com', 'Totoro2') }.to raise_error('Email already registered!')
    end

    it "doesn't allow the same username to be entered twice" do
      User.create('Ghibli', 'studio@ghibli.com', 'Totoro')
      expect { User.create('Ghibli', 'studio2@ghibli.com', 'Totoro2') }.to raise_error('Username already registered!')
    end

    it 'doesnt allow an invalid email' do
      expect { User.create('Ghibli', 'studioghibli.co.uk', 'Totoro2') }.to raise_error('Please enter a valid email!')
    end
  end

  describe '.view' do
    it 'shows all users' do
      connect.exec("INSERT INTO users (username, email, password) VALUES ('Ghibli', 'studio@ghibli.com', 'Totoro')")
      expect(User.view('Ghibli')[0]).to include({
        username: 'Ghibli',
        email: 'studio@ghibli.com', 
        password: 'Totoro'
      })
    end
  end

end

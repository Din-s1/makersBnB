class User
  CON = DBhelper.connect_to_db

  def self.create(username, email, password)
    raise 'Please enter a valid email!' unless valid_email?(email)
    raise 'Email already registered!' unless CON.exec("SELECT email FROM users WHERE email = '#{email}'").first.nil?
    raise 'Username already registered!' unless CON.exec("SELECT username FROM users WHERE username = '#{username}'").first.nil?

    CON.exec("INSERT INTO users (username, email, password) VALUES ('#{username}', '#{email}', '#{password}')")
  end

  def self.view(username)
    res = CON.exec("SELECT * FROM users WHERE username = '#{username}'")
    arr = res.map { |column|
      {
      id: column['id'],
      username: column['username'],
      email: column['email'],
      password: column['password']
      }
    }
    arr.first
  end

  private_class_method

  def self.valid_email?(email)
    email =~ /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  end
end

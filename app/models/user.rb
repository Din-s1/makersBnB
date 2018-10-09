require './spec/dbhelper.rb'

class User
  CONN = DBhelper.connect_to_db

  def self.create(username, email, password)
    raise 'Please enter a valid email!' unless valid_email?(email)
    raise 'Email already registered!' unless CONN.exec("SELECT email FROM users WHERE email = '#{email}'").first.nil?
    raise 'Username already registered!' unless CONN.exec("SELECT username FROM users WHERE username = '#{username}'").first.nil?

    CONN.exec("INSERT INTO users (username, email, password) VALUES ('#{username}', '#{email}', '#{password}')")
  end

  def self.view(username)
    res = CONN.exec("SELECT * FROM users WHERE username = '#{username}'")
    res.map { |column|
      {
      id: column['id'],
      username: column['username'],
      email: column['email'],
      password: column['password']
      }
    }
  end

  private_class_method

  def self.valid_email?(email)
    email =~ /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  end
end

# TODO Create user class
# TODO Create create method
# TODO Create view method
# TODO Create REGEX for emails

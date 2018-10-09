require './spec/dbhelper.rb'

class User
  CONN = DBhelper.connect_to_db

  def self.create(username, email, password)
    CONN.exec("INSERT INTO users (username, email, password) VALUES ('#{username}', '#{email}', '#{password}')" )
  end

  def self.view(username)
    CONN.exec("SELECT * FROM users WHERE username = '#{username}'")
  end
end

# TODO Create user class
# TODO Create create method
# TODO Create view method
# TODO Create REGEX for emails

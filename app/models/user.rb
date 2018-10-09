require './spec/dbhelper.rb'

class User
  CONNECT = DBhelper.connect_to_db
  def self.create(username, email, password)
    CONNECT.exec("INSERT INTO users (username, email, password) VALUES ('#{username}', '#{email}', '#{password}')" )
  end
end

# TODO Create user class
# TODO Create create method
# TODO Create view method
# TODO Create REGEX for emails

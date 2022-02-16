require_relative 'DatabaseConnection'
require 'pg'
require 'bcrypt'

class User
    
    attr_reader :id, :username

    
    def initialize(id:, username:)
        @id = id
        @username = username
    end

   def self.create(username:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query(
        "INSERT INTO users (username, password) VALUES($1, $2) RETURNING id, username;",
        [username, encrypted_password]
    )
    User.new(id: result[0]['id'], username: result[0]['username'])
   end

   def self.find(id)
    return nil unless id
    result = DatabaseConnection.query(
        "SELECT * FROM users WHERE id =$1",
        [id]
    )
    User.new(id: result[0]['id'], username: result[0]['username'])
   end

   def self.authenticate(username:, password:)
    result = DatabaseConnection.query(
        "SELECT * FROM users WHERE username = $1",
        [username]
    )

    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], username: result[0]['username'])
   end
   
  

  

   

   
end
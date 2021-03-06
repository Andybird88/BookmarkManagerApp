require 'database_helpers'
require 'user'

describe '.create' do
    it 'creates a new user' do
        user = User.create(username: 'test@example.com', password: 'password123')
        persisted_data = persisted_data(table: :users, id: user.id)

        expect(user).to be_a User
        expect(user.id).to eq persisted_data.first['id']
        expect(user.username).to eq 'test@example.com'
    end

    it 'finds a user by ID' do
        user = User.create(username: 'test@example.com', password: 'password123')
        result = User.find(id: user)

        expect(result.id).to eq user.id
        ecpect(result.username).to eq user.username
    end

    it 'hashes the password' do
        expect(BCrypt::Password).to receive(:create).with('password123')

        User.create(username: 'test"example.com', password: 'password123')
    end
end

describe '.find' do
    it 'returns nil if there is no USER ID given' do
        expect(User.find(nil)).to eq nil
    end



end

describe '.authenticate' do
    it 'returns a user with correct name and password if one exists' do
      user = User.create(username: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate('test@example.com', 'password123')
      expect(authenticated_user.id).to eq user.id
    end

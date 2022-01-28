require 'bookmark'

describe Bookmark do
    describe '.all' do
        it 'returns all bookmarks' do
            connection = PG.connect(dbname: 'bookmark_manager_test')

            connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
            connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.google.com');")
            connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.askjeeves.com');")
            
            bookmarks = Bookmark.all

            expect(bookmarks).to include("http://www.makersacademy.com")
            expect(bookmarks).to include("http://www.google.com")
            expect(bookmarks).to include("http://www.askjeeves.com")
        end
    end
end
require 'bookmark'
require 'database_helpers'

describe Bookmark do
    let(:comment_class) { double(:comment_class) }

    describe '.all' do
        it 'returns all bookmarks' do
            connection = PG.connect(dbname: 'bookmark_manager_test')

           bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
           Bookmark.create(url: 'http://www.google.com', title: 'Google')
           Bookmark.create(url: 'http://www.askjeeves.com', title: 'Jeeves')
            
            
            bookmarks = Bookmark.all

            expect(bookmarks.length).to eq 3
            expect(bookmarks.first).to be_a Bookmark
            expect(bookmarks.first.id).to eq bookmark.id
            expect(bookmarks.first.title).to eq 'Makers Academy'
            expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
        end
    end
    describe '.create' do
        it 'creats a new bookmark' do
            bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test Bookmark')
            persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)
            
            expect(bookmark).to be_a Bookmark
            expect(bookmark.id).to eq persisted_data['id']
            expect(bookmark.title).to eq 'Test Bookmark'
            expect(bookmark.url).to eq 'http://www.example.org' 
        end
        it 'Does not create a new bookmark if the URl is invalid' do
            Bookmark.create(url: 'Not a real bookmark', title: 'not a real bookmark')
            expect(Bookmark.all).to be_empty
        end
    end

    describe '.delete' do
        it 'deletes the chosen bookmark' do
            bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy' )

            Bookmark.delete(id: bookmark.id)

            expect(Bookmark.all.length).to eq 0
        end
    end

    describe '.update' do
        it 'updates a bookmark' do
            bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
            updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

            expect(updated_bookmark).to be_a Bookmark
            expect(updated_bookmark.id).to eq bookmark.id
            expect(updated_bookmark.title).to eq 'Snakers Academy'
            expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
        
        end
    end

    describe '.find' do
        it 'returns the given bookmark' do
            bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

            result = Bookmark.find(id: bookmark.id)

            expect(result).to be_a Bookmark
            expect(result.id).to eq bookmark.id
            expect(result.title).to eq 'Makers Academy'
            expect(result.url).to eq 'http://www.makersacademy.com'
        end
    end

    describe '#comments' do
        it 'returns a list of comments on the bookmark' do
            bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
            DatabaseConnection.query(
                "INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test commment', $1)",
                [bookmark_id]
            )

            comment = bookmark.comments.first

            expect(comment['text']).to eq 'Test comment'
        end
        it 'calls .where on the comment class' do
            bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
            expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

            bookmark.comments(comment_class)
        end
    end
end
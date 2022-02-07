require 'pg'
require_relative 'DatabaseConnection'
require 'uri'
require_relative './comment'

class Bookmark

    attr_reader :id, :title, :url

    def initialize(id:, url:, title:)
        @id = id
        @title = title
        @url = url
    end
    
    def self.all
      result = DatabaseConnection.query("SELECT * FROM bookmarks")
      result.map do |bookmark| 
        Bookmark.new(
          url: bookmark['url'],
          title: bookmark['title'],
          id: bookmark['id']
        )
      end
    end

    def self.create(url:, title:)
        return false unless is_url?(url)
        result = DatabaseConnection.query(
           "INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, url, title;", [url, title]
        )
       Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
    end

    def self.delete(id:)
        DatabaseConnection.query("DELETE FROM bookmarks WHERE id = $1", [id])
    end

    def self.update(id:, url:, title:)
        
        result = DatabaseConnection.query(
            "UPDATE bookmarks SET url = $1, title = $2 WHERE id =$3 RETURNING id, url, title;",
            [url, title, id]
        )
        Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
    end

    def self.find(id:)
        
        result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = $1;", [id])
        Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
    end

    def comments(comment_class = Comment)
        comment_class.where(bookmark_id: id)
    end


    private

    def self.is_url?(url)
        url =~ /\A#{URI::regexp(['http', 'https'])}\z/
    end
end
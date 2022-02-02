require 'pg'

class Bookmark

    attr_reader :id, :title, :url

    def initialize(id:, url:, title:)
        @id = id
        @title = title
        @url = url
    end
    def self.all
        if ENV['ENVIRONMENT'] == 'test'
            connection = PG.connect(dbname: 'bookmark_manager_test')
        else
            connection = PG.connect(dbname: 'bookmark_manager')  
        end
      
      result = connection.exec("SELECT * FROM bookmarks;")
      result.map { |bookmark| 
        Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'],)
      }
    end

    def self.create(url:, title:)
        if ENV['ENVIRONMENT'] == 'test'
            connection = PG.connect(dbname: 'bookmark_manager_test')
        else
            connection = PG.connect(dbname: 'bookmark_manager')
        end

       result = connection.exec_params(
           "INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, url, title;", [url, title]
        )
       Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
    end

    def self.delete(id:)
        if ENV['ENVIRONMENT'] == 'test'
            connection = PG.connect(dbname: 'bookmark_manager_test')
        else
            connection = PG.connect(dbname: 'bookmark_manager')
        end
        connection.exec_params("DELETE FROM bookmarks WHERE id = $1", [id])
    end
end
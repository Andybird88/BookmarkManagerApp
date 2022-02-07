require 'pg'

def setup_test_database
p "setting up test database...."

connection = PG.connect(dbname: 'bookmark_manager_test')

connection.exec("DROP TABLE comments;")
connection.exec("DROP TABLE bookmarks;")

connection.exec(
    "CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));"
)
connection.exec(
    "ALTER TABLE bookmarks ADD COLUMN title VARCHAR(60);"
)
connection.exec(
    "CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INTEGER REFERENCES bookmarks (id));"
)

end
# BookmarkManagerApp

# About the app
This app aims to manage website bookmarks so that they can be catagorised and commented on. Helping to keep everything organised. 

# Database Set Up.

1. Connect to PSQL
2. Create the database using the `psql` command `CREATE DATABASE bookmark_manager;`
3. Connect to the database using the `psql` command `\c bookmark_manager`
4. Run the query saved in the file `01_create_bookmarks_table.sql`
5. To exit PSQL type `\q`at any time.

# Test Database SetUp

1. Connect to PSQL
2. Create the database using the `psql` command `CREATE DATABASE bookmark_manager_test;`
3. Connect to the database using the `psql` command `\c bookmark_manager_test`
4. Run the query we have saved in the file `01_create_bookmarks_table.sql`

# Add a Title Column to the database

1. Connect to PSQL and `\c bookmark_manager`to connect to the live database.
2. Once connected enter command `ALTER TABLE bookmarks ADD COLUMN title VARCHAR(60);`
3. Connect to `\c bookmark_manager_test` database and repeat step 2(This will add the title column to the test database as well).
4. You can use the psql command `TABLE bookmarks;` to inspect the table and verify that the title column has been added.

# Create a new comments table in the database.

1. Connect to PSQL and `\c bookmark_manager`to connect to the live database.
2. Run the query saved in the file `03_create_comments_table.sql`.
3. Repeat steps 1 and 2 for the test database.

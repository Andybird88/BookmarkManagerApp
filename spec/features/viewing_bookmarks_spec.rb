feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmark.create(url: "http://www.makersacademy.com", title: "Makers")
    Bookmark.create(url: "http://www.google.com", title: "Google")
    Bookmark.create(url: "http://www.askjeeves.com", title: "Jeeves")


    visit('/bookmarks')

    expect(page).to have_link "Makers"
    expect(page).to have_link "Google"
    expect(page).to have_link "Jeeves"
  end
end


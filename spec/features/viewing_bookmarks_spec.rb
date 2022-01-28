feature 'Viewing bookmarks' do
  scenario 'visiting the index page' do
    visit('/bookmarks')
    expect(page).to have_content "http://www.makersacademy.com"
    end
end
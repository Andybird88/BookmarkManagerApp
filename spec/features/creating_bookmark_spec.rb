feature 'Adding new bookmark' do
    scenario 'A user can add a bookmark to bookmark manager' do
        visit('/bookmarks/new')
        fill_in('url', with: 'http://example.org')
        fill_in('title', with: 'Test Bookmark')
        click_button('Submit')

        expect(page).to have_link('Test Bookmark', href: 'http://example.org') 
    end

    scenario 'The bookmark must be a valid URL' do
        visit('/bookmarks/new')
        fill_in('url', with: 'not a real bookmark')
        click_button('Submit')

        expect(page).not_to have_content "not a real bookmark"
        expect(page).to have_content "Please only submit valid URL's."
    end
end
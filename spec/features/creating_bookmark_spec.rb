feature 'Adding new bookmark' do
    scenario 'A user can add a bookmark to bookmark manager' do
        visit('/bookmarks/new')
        fill_in('url', with: 'http://example.org')
        click_button('Submit')

        expect(page).to have_content 'http://example.org'
    end
end
require 'rails_helper'

RSpec.feature "LinkCreations", type: :feature do
  scenario "user creates a new shortened link" do
    link = build(:link)
    
    visit root_path
    fill_in "Url", with: link.url
    fill_in "Slug", with: link.slug
    click_button "Create Link"

    expect(page).to have_content(link.url)
  end
end

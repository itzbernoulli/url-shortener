require 'rails_helper'

RSpec.feature "LinkCreations", type: :feature do
  scenario "user creates a new shortened link" do
    link = build(:link)
    
    visit root_path
    click_link "Create another link"
    fill_in "Url", with: link.url
    fill_in "Slug", with: link.slug
    click_button "Create Link"
  end
end

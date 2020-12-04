require 'rails_helper'

RSpec.feature "LinkLists", type: :feature do
  scenario "user views a list of links on the homepage" do

    visit root_path
    click_link "Create another link"
    expect(page).to have_content("Please input url you want to shorten")
    expect(page).to have_content("Choose a short or leave empty to fill automatically")
  end

  scenario "user navigates to top 100 board" do
    visit root_path
    click_link "View top 100 Links"
    expect(page).to have_content("TOP 100 BOARD")
    expect(page).to have_content("Back Home")
  end
end

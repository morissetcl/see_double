require 'rails_helper'

feature "Share page", js: true do

  scenario "displays 3rd party widgets" do
    visit "/share"
    expect(page).to have_content("Script served by Clément Rollon")
  end

end

require 'rails_helper'

feature "Home page" do

  scenario "visit" do
    visit "/"
    expect(page).to have_title "Best test ever"
    expect(page).to have_css ".welcome"
  end

end

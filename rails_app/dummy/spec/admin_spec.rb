require "rails_helper"

RSpec.describe 'Admin - Artwork - Index', :feature do
  let!(:admin_user) { create :admin_user }

  before :each do
    visit new_admin_user_session_path
    fill_in "admin_user_email".to_sym, with: admin_user.email
    fill_in "admin_user_password".to_sym, with: "password"
    click_on "Login"
  end

  it "display the list of artworks" do
    3.times do |n|
      create :artwork, name: "L'origine du monde #{n}"
    end
    visit admin_artworks_path
    expect(page).to have_content "L'origine du monde 1"
    expect(page).to have_content "L'origine du monde 2"
    expect(page).to have_content "L'origine du monde 3"
  end
end

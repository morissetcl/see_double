require "rails_helper"

RSpec.describe 'Show - User', :feature do
  let!(:user) { create :user }
  let!(:artwork) { create :artwork, owner: user }

  before :each do
    visit new_user_session_path
    fill_in "user_email".to_sym, with: user.email
    fill_in "user_password".to_sym, with: user.password
    click_on "Login"
  end

  it "display one user" do
    visit user_path user
    expect(page).to have_content user.name
    expect(page).to have_content user.first_name
  end

  it "display the user's artworks" do
    visit user_path user
    expect(page).to have_content artwork.name
    expect(page).to have_content artwork.price
    expect(page).to have_content artwork.size
  end
end

require "rails_helper"

RSpec.describe "Artwork#new", :feature do
  let(:user) { create :user }

  before :each do
    visit new_user_session_path
    fill_in "user_email".to_sym, with: user.email
    fill_in "user_password".to_sym, with: user.password
    click_on "Login"
  end

  it 'Create an artwork' do
    visit new_artwork_path
    fill_in :artwork_name, with: 'La Joconde 2.0'
    fill_in :artwork_price, with: '3200'
    fill_in :artwork_artist, with: user.name
    click_on 'Add'
    expect(Artwork.count).to_change by 1
    expect(current_path).to eq artwork_path Artwork.last
    expect(page).to have_content user.name
  end
end

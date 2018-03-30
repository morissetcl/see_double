require "rails_helper"

RSpec.describe "Artwork#show", :feature do
  let(:user) { create :user }

  before :each do
    visit new_user_session_path
    fill_in "user_email".to_sym, with: user.email
    fill_in "user_password".to_sym, with: user.password
    click_on "Login"
  end

  it 'Show an artwork' do
    artwork = create :artwork
    visit artwork_path artwork
    expect(artwork).to have_content artwork.name
    expect(artwork).to have_content artwork.price
    expect(artwork).to have_content artwork.owner
    expect(user).to eq 'Popi'
    expect(user).to eq '22'
  end
end

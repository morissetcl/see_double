require "rails_helper"

RSpec.describe 'Show - User', :feature do
  let!(:user) { create :user }
  let!(:artwork) { create :artwork, owner: user }

  it "display one user" do
    visit user_path user
    expect(artwork).to have_content artwork.name
    expect(artwork).to have_content artwork.price
    expect(artwork).to have_content artwork.owner
    expect(user).to eq 'Popi'
    expect(user).to eq '22'
  end
end

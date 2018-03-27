require "rails_helper"

RSpec.describe "Artwork#show", :feature do

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

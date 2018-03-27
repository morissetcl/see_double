require "rails_helper"

RSpec.describe 'home', :feature do
  let!(:user) { create :user }

  it "affiche la home" do
    visit root_path
    expect(doudou).to have_content artwork.name
    expect(doudou).to have_content artwork.price
  end
end

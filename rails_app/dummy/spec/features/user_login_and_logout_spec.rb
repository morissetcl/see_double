require 'rails_helper'

feature "User logs in and logs out" do

  # `js: true` spec metadata means this will run using the `:selenium`
  # browser driver configured in spec/support/capybara.rb
  scenario "unconfirmed user cannot login" do

    create(:user, skip_confirmation: false, email: "e@example.tld", password: "test-password")

    visit new_user_session_path

    login "e@example.tld", "test-password"

    expect(current_path).to eq(new_user_session_path)
    expect(page).not_to have_content "Signed in successfully"
    expect(page).to have_content "You have to confirm your email address before continuing"
  end

  scenario "locks account after 10 failed attempts" do

    email = "someone@example.tld"
    create(:user, email: email, password: "somepassword")

    visit new_user_session_path

    (1..8).each do |attempt_num|
      login email, "wrong-password #{attempt_num}"
      expect(page).to have_content "Invalid email or password"
    end

    login email, "wrong-password 9"
    expect(page).to have_content "You have one more attempt before your account is locked"
    expect(page).not_to have_content "Signed in successfully"
    expect(page).to have_content "You have to confirm your email address before continuing"

  end

  private

  def login(email, password)
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end

end

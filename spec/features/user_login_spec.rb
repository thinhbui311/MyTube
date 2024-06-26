require "rails_helper"

RSpec.feature "User login feature", type: :feature do
  describe "User Login" do
    before do
      visit "/users/sign_in"
    end

    context "When user login with incorrect credentials" do
      it "prevent a user to log in" do
        fill_in "user_email", with: "adam@gmail.com"
        fill_in "user_password", with: "12345"
        click_button "Log In"

        expect(page).to have_current_path("/users/sign_in")
        expect(page).to have_content("Invalid Email or password")
      end
    end

    context "When user login with correct credentials" do
      it "allows a user to log in then redirect to list video page" do
        fill_in "user_email", with: "adam@gmail.com"
        fill_in "user_password", with: "1234567890"
        click_button "Log In"

        expect(page).to have_current_path("/")
        expect(page).to have_content("Recent videos")
      end
    end
  end
end

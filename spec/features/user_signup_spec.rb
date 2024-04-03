require "rails_helper"

describe "User Registration" do
  before do
    visit "/users/sign_up"
  end

  context "When user fill in wrong required info" do
    it "Should show error messages" do
      fill_in "user_email", with: "John"
      fill_in "user_password", with: "123"
      fill_in "user_password_confirmation", with: "123"
      click_button "Sign up"
      expect(page).to have_content("Email is invalid Password is too short")
    end
  end

  context "When user fill in correct required info" do
    it "Should sign user up" do
      fill_in "user_email", with: "John@gmail.com"
      fill_in "user_password", with: "abc123"
      fill_in "user_password_confirmation", with: "abc123"
      click_button "Sign up"
      expect(page).to have_content("Recent videos")
    end
  end
end

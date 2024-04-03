require "rails_helper"

describe "Share video" do
  before do
    login_as(users(:adam))
  end

  context "When user click share button" do
    it "Should render share video page" do
      visit "/"
      click_link "share-video-button"
      expect(page).to have_content("Share youtube URL")
    end
  end

  context "When in share video page" do
    before do
      visit "/new"
    end

    context "When user leave input fill blank" do
      it "Should flash error notice" do
        click_button "Submit"
        expect(page).to have_content("Url can't be blank")
      end
    end

    context "When user fill in a url is not from youtube" do
      it "Should flash error notice" do
        fill_in "video_url", with: "https://google.com"
        click_button "Submit"
        expect(page).to have_content("Url is invalid")
      end
    end

    context "When user fill in a valid url" do
      it "Should flash success notice" do
        fill_in "video_url", with: "https://youtu.be/4k2verGRZNw?si=Qm_s0EGjGdor8Tla"
        click_button "Submit"
        expect(page).to have_content("Success!")
      end
    end
  end
end

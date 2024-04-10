require "rails_helper"

RSpec.feature "Share video feature", type: :feature, js: true do
  describe "Share video" do
    include ActiveJob::TestHelper

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

          expect(page).to have_current_path("/")
          expect(page).to have_content("Url can't be blank")
        end
      end

      context "When user fill in a url is not from youtube" do
        it "Should flash error notice" do
          fill_in "video_url", with: "https://google.com"
          click_button "Submit"

          expect(page).to have_current_path("/")
          expect(page).to have_content("Url is not from Youtube")
        end
      end

      context "When user fill in a valid url", performs_jobs: true do
        it "Should flash success notice" do
          fill_in "video_url", with: "https://youtu.be/4k2verGRZNw?si=Qm_s0EGjGdor8Tla"
          click_button "Submit"

          expect(page).to have_selector("div.video-item", count: 4)
          expect(page).to have_content("Success!")
        end

        it "Should send notification to other users" do
          visit "/"
          using_session("Eva") do
            ActiveJob::Base.queue_adapter = :test
            login_as(users(:eva))
            visit "/new"
            fill_in "video_url", with: "https://youtu.be/4k2verGRZNw?si=Qm_s0EGjGdor8Tla"
            perform_enqueued_jobs do
              click_button "Submit"
            end
          end

          expect(page).to have_content("eva@gmail.com just shared")
        end
      end
    end
  end
end

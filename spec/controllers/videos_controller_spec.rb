require "rails_helper"

RSpec.describe VideosController, type: :controller do
  describe "GET index" do
    context "When user not log in yet" do
      before do
        get :index
      end

      it "Should response list of all videos" do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
        expect(assigns[:videos].size).to eq 3
      end
    end

    context "When user logged in" do
      it "Should response list of all videos" do
        sign_in(users(:adam))
        get :index
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
        expect(assigns[:videos].size).to eq 3
      end
    end
  end

  describe "GET new" do
    context "When user not log in yet" do
      it "Should redirect to login page" do
        get :new
        expect(response).to have_http_status(:found)
      end
    end

    context "When user logged in" do
      it "Should response new share video page" do
        sign_in(users(:adam))
        get :new
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end
end

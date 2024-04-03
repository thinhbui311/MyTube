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

  describe "POST create" do
    context "When user not log in yet" do
    end

    context "When user logged in" do
      before do
        sign_in(users(:adam))
      end

      context "When url is invalid" do
        let(:url){"https://www.google.com"}

        it "Should response 422 error" do
          post :create, params: {video: {url: url}}
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
        end
      end

      context "When url is valid" do
        let(:url){"https://www.youtube.com/watch?v=iMTblJbmam4"}

        it "Should create a new video share" do
          post :create, params: {video: {url: url}}
          expect(response).to have_http_status(:found)
          expect(flash[:notice]).to be_present
          expect(response).to redirect_to(:videos)
        end

        it "Should enqueue a job to notify other users" do
          ActiveJob::Base.queue_adapter = :test

          expect{post :create, params: {video: {url: url}}}.to have_enqueued_job(NotificationVideoShareJob)
        end
      end
    end
  end
end

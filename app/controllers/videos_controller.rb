class VideosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @videos = Video.all.includes(:user).newest.page(params[:page]).per(12)
  end

  def new
    @video = current_user.videos.build
  end

  def create
    @video = current_user.videos.build(form_params)

    if @video.save
      NotificationVideoShareJob.perform_later(@video.id)
      redirect_to videos_path, notice: "Success!"
    else
      flash.now[:alert] = @video.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def form_params
    params.require(:video).permit(:url)
  end
end

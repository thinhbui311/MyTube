class VideosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @videos = Video.all.includes(:user).newest.page(params[:page]).per(12)
  end

  def new
    @video = current_user.videos.build
  end

  def create
    video = current_user.videos.build(video_params)

    if video.save
      NotificationVideoShareJob.perform_later(video.id)
      redirect_to videos_path
    else
      flash[:error] = video.errors.full_messages.to_sentence
    end
  end

  private

  def form_params
    params.require(:video).permit(:source_url)
  end

  def video_params
    yt_video = ::Yt::Video.new(url: form_params[:source_url])

    {
      source_url: form_params[:source_url],
      title: yt_video.title,
      description: yt_video.description,
      published_at: yt_video.published_at,
      channel_title: yt_video.channel_title,
      thumbnail_url: yt_video.thumbnail_url,
      embed_html: yt_video.embed_html,
      view_count: yt_video.view_count,
      like_count: yt_video.like_count,
      dislike_count: yt_video.dislike_count,
      favorite_count: yt_video.favorite_count,
      comment_count: yt_video.comment_count
    }
  end
end

class Video < ApplicationRecord
  YOUTUBE_HOST = %w(www.youtube.com youtube.com youtu.be).freeze
  INFO_ATTRS = %i(title description published_at channel_title thumbnail_url embed_html
    view_count like_count dislike_count favorite_count comment_count).freeze

  belongs_to :user

  validates :url, presence: true
  validate :url_from_youtube

  after_save :assign_video_info, if: ->{saved_change_to_url?}

  scope :newest, ->{order(created_at: :desc)}

  def assign_video_info
    yt_video = ::Yt::Video.new(url: url)

    self.assign_attributes(INFO_ATTRS.inject({}){|v_params, attr| v_params.merge({attr => yt_video.send(attr)})})
    self.save!
  end

  private

  def url_from_youtube
    return true if YOUTUBE_HOST.include?(URI.parse(url).host)

    errors.add(:url, "is not from Youtube")
  rescue URI::InvalidURIError
    errors.add(:url, "is wrong format!")
  end
end

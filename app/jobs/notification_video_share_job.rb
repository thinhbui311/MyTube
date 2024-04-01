class NotificationVideoShareJob < ApplicationJob
  queue_as :notification

  def perform video_id
    video = Video.find(video_id)
    ActionCable.server.broadcast("notification_channel", {content: "#{video.user.email} just share #{video.title}"})
  end
end

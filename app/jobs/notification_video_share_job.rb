class NotificationVideoShareJob < ApplicationJob
  queue_as :notification

  def perform video_id
    video = Video.find(video_id)
    ActionCable.server.broadcast("notification_channel", {
      content: "#{video.user.email} just shared \n #{video.title}",
      url: video.url
    })
  end
end

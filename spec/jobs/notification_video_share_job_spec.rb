require "rails_helper"

RSpec.describe NotificationVideoShareJob, type: :job do
  include ActiveJob::TestHelper

  let(:video){videos(:movie)}

  subject(:job_later){described_class.perform_later(video.id)}
  subject(:job_now){described_class.perform_now(video.id)}

  it "Should enqueues the job on notification queue" do
    expect{job_later}.to have_enqueued_job(described_class).on_queue("notification")
  end

  it "Should broadcast a noti to notification channel" do
    expect{job_now}.to have_broadcasted_to("notification_channel").with({
      content: "#{video.user.email} just shared \n #{video.title}",
      url: video.url
    })
  end
end

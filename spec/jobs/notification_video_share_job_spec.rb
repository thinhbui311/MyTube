require "rails_helper"

RSpec.describe NotificationVideoShareJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(videos(:movie).id) }

  it "Should enqueues the job" do
    expect {job}.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end
end

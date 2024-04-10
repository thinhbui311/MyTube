require "rails_helper"

RSpec.describe NotificationChannel, type: :channel do
  it "Subscribe to a channel" do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from("notification_channel")
  end
end

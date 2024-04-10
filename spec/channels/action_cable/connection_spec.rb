require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:env){instance_double("env")}
  let(:warden){instance_double("warden", user: user)}

  before do
    allow_any_instance_of(ApplicationCable::Connection).to receive(:env).and_return(env)
    allow(env).to receive(:[]).with("warden").and_return(warden)
  end

  context "When an user verified" do
    let(:user){users(:adam)}

    it "should successfully connects" do
      connect "/cable"
      expect(connect.current_user).to eq user
    end

  end

  context "When an user unverified" do
    let(:user){nil}

    it "should rejects connection" do
      expect {connect "/cable"}.to have_rejected_connection
    end
  end
end

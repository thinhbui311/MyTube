require "rails_helper"

RSpec.describe Video, type: :model do
  subject {described_class.new(url: "")}

  it {should belong_to(:user)}
  it {should validate_presence_of(:url)}

  it "is invalid with empty url" do
    expect(subject).to_not be_valid
  end

  it "is valid with correct url" do
    subject.url = "https://youtu.be/_QwNCenuFSw?si=fglJs9dRZAK9FJzc"
    subject.user = users(:adam)
    expect(subject).to be_valid
  end
end

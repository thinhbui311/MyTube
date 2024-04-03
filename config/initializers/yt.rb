Yt.configure do |config|
  config.api_key = ENV["YT_API_KEY"] || Rails.application.credentials.yt_api_key
end

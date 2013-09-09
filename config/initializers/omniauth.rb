Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, APP_CONFIG['google_client_id'], APP_CONFIG['google_client_secret']
  provider :github, APP_CONFIG['github_client_id'], APP_CONFIG['github_client_secret']
end

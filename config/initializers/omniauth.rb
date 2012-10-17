Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, APP_CONFIG['google_client_id'], APP_CONFIG['google_client_secret']
  provider :twitter, APP_CONFIG['twitter_consumer_key'], APP_CONFIG['twitter_consumer_secret']
  provider :github, APP_CONFIG['github_client_id'], APP_CONFIG['github_client_secret']
  provider :xiaonei, APP_CONFIG['renren_api_key'], APP_CONFIG['renren_secret_key']
  provider :douban, APP_CONFIG['douban_api_key'], APP_CONFIG['douban_secret']
end

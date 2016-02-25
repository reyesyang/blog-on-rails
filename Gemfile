source 'https://ruby.taobao.org/'

gem 'rails', '~> 4.0.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Previously the assets group existed to avoid unintended compilation-on-demand
# in production. As Rails 4 doesn't behave like that anymore, it made sense to
# remove the asset group.
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# To use Less stylesheets, you'll need the less-rails gem, and one of JavaScript runtimes supported by CommonJS.
gem 'therubyracer', platforms: :ruby
gem 'less-rails'
gem 'twitter-bootstrap-rails'

gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jquery-turbolinks'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.5.1'

# gem "acts_as_ferret", :git => "https://github.com/jkraemer/acts_as_ferret.git"
# gem "jk-ferret"
# gem "rmmseg-cpp"
gem 'will_paginate', '>=3.0.pre'
# gem 'bootstrap-will_paginate'
gem 'wmd-rails'
gem 'redcarpet'
gem "haml-rails"
gem 'rails-i18n', '~>4.0.0'
gem 'dalli'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.0'

# Use unicorn as the web server
gem 'unicorn'

# Use for New Relic
gem 'newrelic_rpm'

gem 'omniauth'
gem 'omniauth-github'

group :development do
  # Deploy with Capistrano
  gem 'capistrano', '~> 3.0.0', require: false
  gem 'capistrano-rbenv', '~> 2.0', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', '~> 1.1.0', require: false
end

group :development, :test do
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'rspec-rails'
  gem 'factory_girl_rails'

  gem 'dotenv-rails'
  # Use debugger
  # gem 'debugger', group: [:development, :test]
end

group :test do
  gem "fakeweb"
  gem "shoulda-matchers"
  gem "capybara"
  gem "selenium-webdriver"
  gem "launchy"
  gem "database_cleaner"
  gem "show_me_the_cookies"
  gem "simplecov", require: false
end

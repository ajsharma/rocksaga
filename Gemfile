source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.2'
gem 'protected_attributes'
gem 'compass-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'cancan'
gem 'figaro'
gem 'foundation-rails'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'pg'
gem 'rolify'
gem 'thin'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'factory_girl_rails'
end
group :production do 
  gem 'rails_12factor' # requested by heroku to avoid deprecation errors on rails 3
end

# hosting
gem 'heroku'
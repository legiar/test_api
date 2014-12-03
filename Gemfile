source 'https://rubygems.org'

gem 'rails',                          '4.1.8'
gem 'rails-api',                      '0.3.1'
gem 'pg'
gem 'unicorn'
gem 'oj',                             '~> 2.11.1'
gem 'faraday'

gem 'sdoc', '~> 0.4.0',               group: :doc

gem 'goliath',                        require: false

group :development do
  gem 'spring'

  gem 'foreman'

  gem 'capistrano',                   '3.3.3', require: false
  gem 'capistrano-bundler',           '1.1.3', require: false
  gem 'capistrano-rvm',               '0.1.2', require: false
  gem 'capistrano-rails',             '1.1.2', require: false
  gem 'capistrano3-unicorn',          '0.2.1', require: false
end

group :development, :test do
  gem 'rspec-rails',                  '~> 3.1.0'
  gem 'json_spec',                    '~> 1.1.4'

  gem 'factory_girl_rails',           '~> 4.5.0'
  gem 'database_cleaner'
  gem 'test_after_commit'

  gem 'webmock',                      require: false

  gem 'simplecov',                    require: false
end

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers',     '~> 0.10.7'
gem 'devise',                       '~> 4.5.0'
gem 'mysql2',                       '~> 0.5.2'
gem 'puma',                         '~> 3.7'
gem 'rails',                        '~> 5.1.6'
gem 'redis',                        '~> 3.0.4'
gem 'redis-namespace',              '~> 1.3.2'
gem 'simple_token_authentication',  '~> 1.0'
gem 'yard',                         '~> 0.9.16'

group :pry do
  gem 'awesome_print',              '1.8.0'
  gem 'byebug',                     '9.1.0'
  gem 'pry',                        '0.11.3'
  gem 'pry-byebug',                 '3.5.0'
  gem 'pry-doc',                    '0.11.1'
  gem 'pry-rails',                  '0.3.6'
end

group :development do
  gem 'listen',                     '>= 3.0.5', '< 3.2'
  gem 'rubocop',                    '0.53.0', require: false
  gem 'spring',                     '~> 2.0.2'
  gem 'spring-watcher-listen',      '~> 2.0.0'
end

group :development, :test do
  gem 'factory_bot_rails',          '4.11.0', require: false
  gem 'rspec-rails',                '~> 3.8.0'
end

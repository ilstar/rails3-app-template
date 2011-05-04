source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'mysql2', '0.2.7'

gem 'will_paginate', '3.0.pre2'

# gem "simple_form"

group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem "factory_girl_rails"
  gem "watchr"

  if RUBY_VERSION =~ /^1.8/
    gem 'ruby-debug'
  elsif RUBY_VERSION =~ /^1.9/
    gem 'ruby-debug19'
  end
end

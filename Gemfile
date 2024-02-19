# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.2"

gem "bootsnap", require: false
gem "dry-transaction", "~> 0.16.0"
gem "minitest-rails", "~> 7.1.0"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3"
gem "sqlite3", "~> 1.4"
gem "tzinfo-data", platforms: [:windows, :jruby]

group :development, :test do
  gem "debug", platforms: [:mri, :windows]
  gem "rubocop", "~> 1.57", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
end

group :development do
  gem "pry-rails", "~> 0.3.9"
  gem "ruby-lsp", require: false
end

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "5.1.6"
gem "dotenv-rails"
gem "bcrypt", "3.1.12"
gem "carrierwave", "1.2.2"
gem "mini_magick", "4.7.0"
gem "bootstrap-sass", "3.4.1"
gem "puma", "3.12.4"
gem "sass-rails", "5.0.6"
gem "uglifier", "3.2.0"
gem "coffee-rails", "4.2.2"
gem "jquery-rails", "4.3.1"
gem "turbolinks", "5.0.1"
gem "jbuilder", "2.7.0"
gem "pg", "0.20.0"
gem "simplecov", require: false, group: :test
group :development, :test do
  gem "byebug", "9.0.6", platform: :mri
end

group :development do
  gem "web-console", "3.5.1"
  gem "listen", "3.1.5"
  gem "spring", "2.0.2"
  gem "spring-watcher-listen", "2.0.1"
end

group :test do
  gem "rails-controller-testing", "1.0.2"
  gem "minitest", "5.10.3"
  gem "minitest-reporters", "1.1.14"
  gem "guard", "2.13.0"
  gem "guard-minitest", "2.4.4"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

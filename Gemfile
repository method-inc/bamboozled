source "http://rubygems.org"
gemspec

group :test do
  gem "coveralls", require: false
end

group :development, :test do
  gem "listen", "3.0.7"
  gem "guard"
  gem "guard-rspec", require: false
  gem "guard-rubocop", require: false
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false

  gem "pronto"
  gem "pronto-rubocop", require: false
  gem "pronto-flay", require: false
  gem "pronto-reek", require: false
  gem "pronto-brakeman", require: false
end

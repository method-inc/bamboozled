workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Installing Bundler" {
  uses = "docker://ruby:2.5"
  args = "gem install bundler"
}

action "Bundling" {
  uses = "docker://ruby:2.5"
  args = "bundle install"
  needs = ["Installing Bundler"]
}

action "Running Tests" {
  uses = "./"
  needs = ["Bundling"]
  args = "rspec"
}

action "Run Rubocop" {
  uses = "./"
  needs = ["Running Tests"]
  args = "rubocop"
}

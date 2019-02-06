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
  args = "bundle install && rspec"
  needs = ["Installing Bundler"]
}

action "Running Tests" {
  uses = "docker://ruby:2.5"
  needs = ["Bundling"]
  args = "rspec"
}

action "Run Rubocop" {
  uses = "docker://ruby:2.5"
  needs = ["Running Tests"]
  args = "rubocop"
}

workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Install Gems" {
  uses = "./"
  args = "bundle install --path=$GITHUB_WORKSPACE/bundle"
}

action "Running Tests" {
  uses = "./"
  args = "bundle install --path=$GITHUB_WORKSPACE/bundle"
  needs = ["Install Gems"]
}

action "Run Rubocop" {
  uses = "./"
  needs = ["Running Tests"]
  args = "bundle exec rubocop"
}
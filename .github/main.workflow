workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Install Gems" {
  uses = "./"
  args = "bundle install"
}

action "Running Tests" {
  uses = "./"
  args = "rspec"
  needs = ["Install Gems"]
}

action "Run Rubocop" {
  uses = "./"
  needs = ["Running Tests"]
  args = "rubocop"
}
workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Install Gems" {
  uses = "./"
  args = "bundle install"
  needs = ["Install Gems"]
}

action "Running Tests" {
  uses = "./"
  args = "rspec"
}

action "Run Rubocop" {
  uses = "./"
  needs = ["Running Tests"]
  args = "rubocop"
}
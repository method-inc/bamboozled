workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Bundling" {
  uses = "./action/"
  args = "bundle install"
}

action "Running Tests" {
  uses = "./action/"
  needs = ["Bundling"]
  args = "bundle show rspec"
}

action "Run Rubocop" {
  uses = "./action/"
  needs = ["Running Tests"]
  args = "rubocop"
}

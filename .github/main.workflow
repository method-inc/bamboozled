workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
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
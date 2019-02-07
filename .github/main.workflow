workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Running Tests" {
  uses = "./"
  args = "rspec"
  secrets = ["GITHUB_TOKEN"]
}

action "Run Rubocop" {
  uses = "./"
  needs = ["Running Tests"]
  args = "rubocop"
}
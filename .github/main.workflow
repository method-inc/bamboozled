workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Running Tests" {
  uses = "Skookum/bamboozled@actions-splybon"
  args = "rspec"
  secrets = ["GITHUB_TOKEN"]
}

action "Run Rubocop" {
  uses = "Skookum/bamboozled@actions-splybon"
  needs = ["Running Tests"]
  args = "rubocop"
}
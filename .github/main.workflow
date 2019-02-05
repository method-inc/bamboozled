workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Running Tests" {
  uses = "Skookum/bamboozled@actions-splybon"
  args = "rspec"
}

action "Run Rubocop" {
  uses = "Skookum/bamboozled@actions-splybon"
  needs = ["Running Tests"]
  args = "rubocop"
}

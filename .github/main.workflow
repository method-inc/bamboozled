workflow "Main Workflow" {
  on = "push"
  resolves = ["Rspec"]
}

action "Rubocop" {
  uses = "./"
  args = "rubocop"
}

action "Rspec" {
  uses = "./"
  args = "rspec"
  needs = "Rubocop"
}

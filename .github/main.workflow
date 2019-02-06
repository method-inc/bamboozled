workflow "Main Workflow" {
  on = "push"
  resolves = ["Testing"]
}

action "Rubocop" {
  uses = "./actions/ci"
  args = "rubocop"
}

action "Testing" {
  uses = "./actions/ci"
  args = "rspec"
}

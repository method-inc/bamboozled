workflow "Main Workflow" {
  on = "push"
  resolves = ["Testing"]
}

action "Rubocop" {
  uses = "./ci-action"
  args = "rubocop"
}

action "Testing" {
  uses = "./ci-action"
  args = "rspec"
  needs = "Rubocop"
}

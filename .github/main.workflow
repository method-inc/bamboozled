workflow "Main Workflow" {
  on = "push"
  resolves = ["Rspec"]
}

action "Install 1" {
  uses = "./ci-action"
  args = "install"
}

action "Install 2" {
  uses = "./ci-action"
  args = "install"
  needs = "Install 1"
}

action "Rubocop" {
  uses = "./ci-action"
  args = "exec rubocop"
  needs = "Install 2"
}

action "Rspec" {
  uses = "./ci-action"
  args = "exec rspec"
  needs = "Rubocop"
}

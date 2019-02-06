workflow "Main Workflow" {
  on = "push"
  resolves = ["Rspec"]
}

action "Install" {
  uses = "./ci-action"
  args = "install"
}

action "Rubocop" {
  uses = "./ci-action"
  args = "exec rubocop"
  needs = "Install"
}

action "Rspec" {
  uses = "./ci-action"
  args = "exec rspec"
  needs = "Rubocop"
}

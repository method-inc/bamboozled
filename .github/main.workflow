workflow "Main Workflow" {
  on = "push"
  resolves = ["Rspec"]
}

action "Rubocop" {
  uses = "./Dockerfile"
  args = "rubocop"
}

action "Rspec" {
  uses = "./Dockerfile"
  args = "rspec"
  needs = "Rubocop"
}

workflow "Main Workflow" {
  on = "push"
  resolves = ["Rspec"]
}

action "Rubocop" {
  uses = "Skookum/bamboozled@actions-splybon"
  args = "rubocop"
}

action "Rspec" {
  uses = "./"
  args = "rspec"
  needs = "Rubocop"
}

workflow "New workflow" {
  on = "push"
  resolves = ["Running Tests"]
}

action "Install Gems" {
  uses = "Skookum/bamboozled@actions-splybon"
  args = "bundle install"
  secrets = ["GITHUB_TOKEN"]
}

action "Running Tests" {
  uses = "Skookum/bamboozled@actions-splybon"
  needs = ["Install Gems"]
  args = "rspec"
}

workflow "New workflow" {
  on = "push"
  resolves = ["Install Gems"]
}

action "Install Gems" {
  uses = "Skookum/bamboozled@actions-splybon"
  args = "bundle install"
  secrets = ["GITHUB_TOKEN"]
}

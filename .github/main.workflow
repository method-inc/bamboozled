workflow "New workflow" {
  on = "push"
  resolves = ["Install Gems"]
}

action "Install Gems" {
  uses = "docker://ruby2.2"
  args = "bundle install"
}

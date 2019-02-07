workflow "New workflow" {
  on = "push"
  resolves = ["Running Tests"]
  resolves = ["Run Rubocop"]
}

action "Install Gems" {
action "Running Tests" {
  uses = "Skookum/bamboozled@actions-splybon"
  args = "bundle install"
  secrets = ["GITHUB_TOKEN"]
  args = "rspec"
}

action "Running Tests" {
action "Run Rubocop" {
  uses = "Skookum/bamboozled@actions-splybon"
  needs = ["Install Gems"]
  args = "rspec"
  needs = ["Running Tests"]
  args = "rubocop"
}
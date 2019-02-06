workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Bundling" {
  uses = "./"
  args = "bundle install"
}

action "Running Tests" {
  uses = "./"
  needs = ["Bundling"]
  args = "bundle show rspec"
}

action "Run Rubocop" {
  uses = "docker://ruby:2.5"
  needs = ["Running Tests"]
  args = "rubocop"
}

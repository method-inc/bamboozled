workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Bundling" {
  uses = "./"
  args = "bundle install"
}

action "Running Tests" {
  uses = "docker://ruby:2.5"
  needs = ["Bundling"]
  args = "rspec"
}

action "Run Rubocop" {
  uses = "docker://ruby:2.5"
  needs = ["Running Tests"]
  args = "rubocop"
}

workflow "New workflow" {
  on = "push"
  resolves = ["Bundling"]
}

action "Bundling" {
  uses = "./"
  args = "gem install bundler && bundle install"
}

action "Running Tests" {
  uses = "./"
  needs = ["Bundling"]
  args = "rspec"
}

action "Run Rubocop" {
  uses = "./"
  needs = ["Running Tests"]
  args = "rubocop"
}

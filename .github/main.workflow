workflow "New workflow" {
  on = "push"
  resolves = ["Run Rubocop"]
}

action "Bundling" {
  uses = "docker://ruby:2.2"
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

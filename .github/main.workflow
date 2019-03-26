workflow "Test and Lint" {
  on = "push"
  resolves = ["rspec", "rubocop"]
}

action "build" {
  uses = "actions/docker/cli@master"
  args = "build -f Dockerfile -t ci-$GITHUB_SHA:latest ."
}

action "rubocop" {
  uses = "actions/docker/cli@master"
  needs = ["build"]
  args = "run ci-$GITHUB_SHA:latest rubocop"
}

action "rspec" {
  uses = "actions/docker/cli@master"
  needs = ["build"]
  args = "run ci-$GITHUB_SHA:latest rspec"
}

workflow "Package Ruby Gem" {
  on = "release"
  resolves = ["Push the gem"]
}

action "Build the gem" {
  uses = "scarhand/actions-ruby@master"
  args = "build *.gemspec"
}

action "Push the gem" {
  uses = "scarhand/actions-ruby@master"
  needs = ["Build the gem"]
  args = "push *.gem"
  secrets = ["RUBYGEMS_AUTH_TOKEN"]
}

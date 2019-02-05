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
}

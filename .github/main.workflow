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
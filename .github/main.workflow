workflow "CI Workflow" {
  on = "push"
  resolves = ["echoing"]
}

action "echoing" {
  uses = "./action-a"
  args = "Hello World"
}

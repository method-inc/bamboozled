# Contributing

Contributions are always welcome! If you discover issues or have ideas for
improvements, report them or submit pull requests. Please follow the guidelines
below when doing so.

## Issue Reporting

* Make sure the issue has not already been reported.
* Check that the issue has not already been fixed in `master`.
* Open a [new issue](https://github.com/Skookum/bamboozled/issues/new) with a
  clear and concise description of the problem.
* Include any relevant code or error output in the issue summary.

## Pull Request

* Fork the project.
* Create a new branch for your feature/bug.
* Get coding!
* Write good tests. See [Testing](#testing).
* Follow the same coding conventions as the rest of the project. See [Coding Style](#coding-style).
* Squash related commits when needed and write good commit messages.
* Add an entry to the [Changelog](CHANGELOG.md) accordingly. See [Changelog Entries](#changelog-entries).
* Make sure the test suite is passing and that there are no style violations
  before pushing your code.
* Pull requests should be related to a single subject.
* Open a pull request until you are happy with your contribution.

### Testing

Always include tests with you code. Bamboozled uses [RSpec](https://github.com/rspec/rspec)
for testing. We like to follow the recommendations listed in [Better Specs](http://betterspecs.org/).

```sh
# Run the entire test suite.
bundle exec rspec

# Run specific test files.
bundle exec rspec spec/lib/bamboozled/lib/employee_spec.rb
```

Alternatively, the `Gemfile` includes [Guard](https://github.com/guard/guard), a
file watcher that will automatically run `rspec` when a file is saved. This is
not a requirement but we encourage running `bundle exec guard` before starting
development so that you are able to catch failed tests as you code away :-).

### Coding Style

Bamboozled leverages [Hound](https://houndci.com/) to maintain the code style
consistent. Hound uses [rubocop](https://github.com/bbatsov/rubocop), which you
can run locally:

```sh
# Run for the entire codebase.
bundle exec rubocop

# Run for a specific file.
bundle exec rubocop lib/bamboozled.rb
```

Just like with tests, `guard` will automatically run `rubocop` when a file is
saved (unless a test fails). Once again, we would like to encourage running
`bundle exec guard` before starting development.

Hound will comment on pull requests with style violations, and pull requests
won't be merged until violations are corrected.

### Changelog Entries

* Use [Markdown syntax](http://daringfireball.net/projects/markdown/syntax).
* The entry line should start with a bullet point `*`.
* If the change has a related GitHub issue, include a link to it as
  `[#1](https://github.com/Skookum/bamboozled/issues/1):`.
* Provide a brief summary of the change.
* At the end of the entry, add an implicit link to your GitHub user page as `([@username][])`.
* If this is your first contribution, add a link definition for the implicit
  link to the bottom of the changelog as `[@username]:
  https://github.com/username`.

Here are a few examples:

```
* [#3](https://github.com/Skookum/bamboozled/issues/3): Added `HashWithIndifferentAccess` to to fix inconsistencies when accessing data. ([@markrickert][])
* New method `Employee#add` allows client to create new employees. ([@kylefdoherty][])
```

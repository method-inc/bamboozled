require "coveralls"
Coveralls.wear!

require "webmock/rspec"
require "rspec"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # Only allow the expectation syntax
    expectations.syntax = :expect

    # Include custom matcher descriptions in output
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # Disable monkey patching for describe
  config.expose_dsl_globally = false
  config.disable_monkey_patching!

  if config.files_to_run.one?
    # Use the documentation formatter for detailed output
    config.default_formatter = "doc"
  end

  # Run specs in random order to surface order dependencies
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option
  Kernel.srand config.seed
end

require "bamboozled"

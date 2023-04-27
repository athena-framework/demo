ENV["ATHENA_ENV"] = "test"

require "spec"
require "../src/main"
require "athena/spec"

DATABASE = DB.open ENV["DATABASE_URL"]

require "./integration_test_case"

Spec.before_suite do
  Micrate.connection_url = ENV["DATABASE_URL"]
  Micrate::Cli.run_up
end

Spec.after_suite do
  DATABASE.close
end

ASPEC.run_all

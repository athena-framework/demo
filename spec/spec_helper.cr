ENV["ATHENA_ENV"] = "test"

require "spec"
require "../src/main"
require "athena/spec"

DATABASE = DB.open ENV["DATABASE_URL"]

Spec.before_suite do
  Micrate.connection_url = ENV["DATABASE_URL"]
  Micrate::Cli.run_up
end

Spec.after_suite do
  DATABASE.close
end

Spec.before_each do
  DATABASE.exec "TRUNCATE TABLE \"articles\" RESTART IDENTITY;"
end

ASPEC.run_all

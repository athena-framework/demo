ENV["ATHENA_ENV"] = "test"

require "spec"
require "../src/main"
require "athena/spec"
require "athena-orm/spec"

DATABASE = DB.open ENV["DATABASE_URL"]

Spec.before_suite do
  Micrate.up DATABASE
end

ASPEC.run_all

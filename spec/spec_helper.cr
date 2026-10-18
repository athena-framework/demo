ENV["ATHENA_ENV"] = "test"

require "spec"
require "../src/main"
require "athena/spec"
require "athena-orm/spec"

Spec.before_suite do
  AORM::Spec.migrate_database
end

ASPEC.run_all

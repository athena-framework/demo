ENV["ATHENA_ENV"] = "test"

require "spec"
require "../src/main"
require "athena/spec"
require "athena-orm/spec"

ASPEC.run_all

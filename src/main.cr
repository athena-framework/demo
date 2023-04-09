require "athena"

require "pg"

require "json"

require "./commands/*"
require "./domain/*"

require "./entities/entity"
require "./entities/repository"
require "./entities/soft_deletable"
require "./entities/created_at_aware"
require "./entities/updated_at_aware"
require "./entities/*"

require "./exceptions/*"
require "./listeners/*"
require "./resolvers/*"
require "./services/*"

require "./controllers/*"

module Blog
  VERSION = "0.1.0"

  module Commands; end

  module Controllers; end

  module Domain; end

  module Entities; end

  module Exceptions; end

  module Listeners; end

  module Services; end
end

# Setup common to both CLI and HTTP contexts

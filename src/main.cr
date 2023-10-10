require "athena"
require "athena-dotenv"

require "pg"

require "json"

require "./entities/entity"
require "./entities/repository"
require "./entities/soft_deletable"
require "./entities/created_at_aware"
require "./entities/updated_at_aware"
require "./entities/*"

require "./commands/*"
require "./listeners/*"
require "./resolvers/*"

require "./services/*"
require "./controllers/*"

module Blog
  VERSION = "0.1.0"

  module Commands; end

  module Controllers; end

  module Entities; end

  module Resolvers; end

  module Services; end
end

# Setup common to both CLI and HTTP contexts

# Load in `.env` files.
private ENV_FILE_NAME = "./.env"

if File.file? ENV_FILE_NAME
  Athena::Dotenv
    .new(Athena::ENV_NAME)
    .load_environment(ENV_FILE_NAME)
end

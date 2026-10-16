require "athena"
require "athena-dotenv"
require "athena-mercure/bundle"
require "athena-orm/bundle"
require "athena-orm/migrations"
require "athena-validator/bundle"
require "athena-console/bundle"

require "jwt"
require "pg"

require "json"

require "./entities/soft_deletable"
require "./entities/created_at_aware"
require "./entities/updated_at_aware"
require "./entities/*"

require "./commands/*"
require "./listeners/*"
require "./migrations/*"
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
    .new(ATH::ENV_NAME)
    .load_environment(ENV_FILE_NAME)
end

ADI.configure({
  orm: {
    url:        ENV["DATABASE_URL"],
    migrations: {
      namespace: "Blog::Migrations",
      directory: "#{__DIR__}/migrations",
    },
  },
  mercure: {
    hubs: {
      default: {
        url: ENV["MERCURE_URL"],
        jwt: {
          secret:    ENV["MERCURE_JWT_SECRET"],
          publish:   ["*"],
          subscribe: ["*"],
          claims:    {
            "iss"       => ENV["MERCURE_JWT_ISSUER"],
            "sub"       => "athena-demo-blog",
            "client_id" => "athena-demo-blog",
          },
        },
      },
    },
  },
})

require "micrate"

@[ACONA::AsCommand("db:migrate")]
@[ADI::Register]
class Blog::Commands::DBMigrate < ACON::Command
  protected def execute(input : ACON::Input::Interface, output : ACON::Output::Interface) : ACON::Command::Status
    # TODO: Remove this once https://github.com/amberframework/micrate/pull/88 is resolved.
    Micrate.connection_url = ENV["DATABASE_URL"]
    Micrate::Cli.run_up

    Status::SUCCESS
  end
end
